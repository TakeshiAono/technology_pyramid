class Technology < ApplicationRecord
  validates :name, presence: true, length: {maximum: 10 }

  has_many :links, dependent: :destroy
  has_many :hierarckies, dependent: :destroy
  has_many :lower_hierarckies,class_name: "Hierarcky", foreign_key: :lower_technology_id, dependent: :destroy
  has_many :lower_technologies, through: :hierarckies, source: :upper_technology
  has_many :upper_technologies, through: :lower_hierarckies, source: :technology
  belongs_to :work

  accepts_nested_attributes_for :hierarckies
end
