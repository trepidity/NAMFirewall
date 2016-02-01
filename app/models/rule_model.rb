class RuleModel < ActiveRecord::Base
  # attr_reader rules
  has_many :nam_components, dependent: :destroy
  has_one :network_detail

  def idps
    nam_components.where(:component_type => 'idp')
  end

  def ags
    nam_components.where(:component_type => 'ag')
  end

  def admins
    nam_components.where(:component_type => 'admin')
  end

  def kerbs
    nam_components.where(:component_type => 'kerb')
  end

  def ldaps
    nam_components.where(:component_type => 'ldap')
  end


  def rules
    rules = Array.new
    admin_ports = [8444, 1289, 524, 636, 'ICMP']
    idp_ports = [1443, 80, 443]
    ag_ports = [1443, 80, 443]
    kerb_ports = [636, 88]
    ldap_ports = [636]
    idp_cluster_ports = [7801, 7802]
    ag_cluster_ports = [7801, 7802]
    ac_cluster_ports = [524, 636, 1289]

# build the rules for the IDP servers
    idps.each { |idp|

      # so the IDP servers can talk to each other
      if network_detail.fw_separates_idp
        idps.each do |other|
          next if idp.ipaddress.eql?(other.ipaddress)
          rule = Rule.new
          rule.source = idp.ipaddress
          rule.dest = other.ipaddress
          rule.port = idp_cluster_ports
          rule.comment = "#Identity Server #{idp.name} to Identity Server #{other.name}"
          rules.push(rule)
        end
      end

      # build connections to the admin servers
      admins.each { |admin|
        rule = rule_add(idp, admin)
        rule.port = admin_ports
        rule.comment = "#Identity Server #{idp.name} to Admin Console #{admin.name}"
        rules.push(rule)

        # reverse side
        rule = Rule.new
        rule.source = admin.ipaddress
        rule.dest = idp.ipaddress
        rule.port = idp_ports
        rule.comment = "#Admin Console #{admin.name} to Identity Server #{idp.name}"
        rules.push(rule)
      }

      # for IDP to eDirectory
      unless ldaps.nil?
        ldaps.each { |ldap|
          rule = Rule.new
          rule.source = idp.ipaddress
          rule.dest = ldap.ipaddress
          rule.port = ldap_ports
          rule.comment = "#Identity Server #{idp.name} to LDAP user store"
          rules.push(rule)
        }
      end

      # for IDP to Active Directory
      unless kerbs.nil?
        kerbs.each { |kerb|
          rule = Rule.new
          rule.source = idp.ipaddress
          rule.dest = kerb.ipaddress
          rule.port = kerb_ports
          rule.comment = "#Identity Server #{idp.name} to Active Directory"
          rules.push(rule)

          # IDP to Kerberos
          rule = Rule.new
          rule.source = idp.ipaddress
          rule.dest = kerb.ipaddress
          rule.port = kerb_ports
          rule.comment = "#For kerberos authentication"
          rules.push(rule)

        }
      end
    }

    # build the rules for the Access Gateways
    ags.each { |ag|

      # so the Gateway servers can talk to each other
      if network_detail.fw_separates_ag
        ags.each do |other|
          next if ag.ipaddress.eql?(other.ipaddress)
          rule = Rule.new
          rule.source = ag.ipaddress
          rule.dest = other.ipaddress
          rule.port = ag_cluster_ports
          rule.comment = "#Access Gateway #{ag.name} to Access Gateway #{other.name}"
          rules.push(rule)
        end
      end


      # AG to ADMIN
      admins.each { |admin|
        rule = Rule.new
        rule.source = ag.ipaddress
        rule.dest = admin.ipaddress
        rule.port = admin_ports
        rule.comment = "#Access Gateway #{ag.name} to Admin Console #{admin.name}"
        rules.push(rule)

        # reverse side
        rule = Rule.new
        rule.source = admin.ipaddress
        rule.dest = ag.ipaddress
        rule.port = ag_ports
        rule.comment = "#Admin Console #{admin.name} to Access Gateway #{ag.name}"
        rules.push(rule)
      }
    }

    # build the rules for the ADMIN consoles
    admins.each { |admin|

      # so the Admin servers can talk to each other
      if network_detail.fw_separates_ac
        admins.each do |other|
          next if admin.ipaddress.eql?(other.ipaddress)
          rule = Rule.new
          rule.source = admin.ipaddress
          rule.dest = other.ipaddress
          rule.port = ac_cluster_ports
          rule.comment = "#Admin Console #{admin.name} to Admin Console #{other.name}"
          rules.push(rule)
        end
      end

      # ADMIN to LDAP server (eDirectory)
      ldaps.each { |ldap|
        rule = Rule.new
        rule.source = admin.ipaddress
        rule.dest = ldap.ipaddress
        rule.port = ldap_ports
        rule.comment = "#Admin console #{admin.name} to LDAP user store. This allows the admin console to import that LDAP certificates"
        rules.push(rule)
      }

      # ADMIN to Active Directory LDAP port
      kerbs.each { |kerb|
        rule = Rule.new
        rule.source = admin.ipaddress
        rule.dest = kerb.ipaddress
        rule.port = kerb_ports
        rule.comment = "#Admin console #{admin.name} to Active Directory User store."
        rules.push(rule)
      }
    }

    puts "Built #{rules.count} rules"
    rules
  end

  private

  # need to switch everything over to this.
  def rule_add(source, dest)
    rule = Rule.new
    rule.source = source.ipaddress
    rule.dest = dest.ipaddress

    case source.component_type
      when :idp
        rule.port = idp_ports
      when :kerb
        rule.port = kerb_ports
      else
        Rails.logger.warn "Could find a component type match for #{source.inspect}"
    end
    rule
  end
end
