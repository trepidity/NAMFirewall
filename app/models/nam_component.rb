class NamComponent < ActiveRecord::Base
  belongs_to :rule_model
  validates_length_of :name, :in => (2..25)
  validates_format_of :ipaddress, :with => Resolv::IPv4::Regex
  validates_format_of :name, :with => /\A[a-z][a-z0-9_\-]*\z/i
end
