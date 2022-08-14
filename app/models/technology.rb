class Technology < ApplicationRecord
  has_many :links, dependent: :destroy
  belongs_to :work
  belongs_to :upper_tech, class_name: "Technology", foreign_key:"upper_technology", optional: true
  belongs_to :lower_tech, class_name: "Technology", foreign_key:"lower_technology", optional: true
  has_many :parent_technologies, class_name: "Pyramid", foreign_key: 'parent_technology_id'
  has_many :child_technologies, class_name: "Pyramid", foreign_key: 'child_technology_id'
end
