class Pyramid < ApplicationRecord
  has_many :link_access_counters, dependent: :destroy
  # belongs_to :technology, class_name: "Technology", foreign_key:"lower_technology", optional: true
  belongs_to :parent_technology, class_name: "Technology", foreign_key: 'parent_technology_id'
  belongs_to :child_technology, class_name: "Technology", foreign_key: 'child_technology_id'
end
