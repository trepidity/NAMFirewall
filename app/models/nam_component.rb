class NamComponent < ActiveRecord::Base
  belongs_to :rule_model
  validates_length_of :name, :in => (2..25)
end
