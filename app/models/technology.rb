class Technology < ApplicationRecord
  has_many :links
  belongs_to :work
  belongs_to :upper_tech, class_name: "Technology", foreign_key:"upper_technology", optional: true
  belongs_to :lower_tech, class_name: "Technology", foreign_key:"lower_technology", optional: true
end
