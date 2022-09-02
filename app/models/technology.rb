class Technology < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :hierarckies, dependent: :destroy
  has_many :lower_hierarckies,class_name: "Hierarcky", foreign_key: :lower_technology_id

  belongs_to :work
  # has_many :lower_technologies, class_name: "hierarckies", foreign_key: :technology_id

  has_many :lower_technologies, through: :hierarckies, source: :upper_technology
  has_many :upper_technologies, through: :lower_hierarckies, source: :technology

  accepts_nested_attributes_for :hierarckies

  technologies_hash = {}
  technologies_hash.store("設定無", nil)
  self.all.each do |technology|
    technologies_hash.store(technology.name,technology.id)
  end
  
  enum technology: technologies_hash

end
