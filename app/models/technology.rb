class Technology < ApplicationRecord
  has_many :links, dependent: :destroy
  belongs_to :work
  # has_many :lower_technologies, class_name: "hierarckies", foreign_key: :technology_id
  
  has_many :hierarckies, dependent: :destroy
  has_many :lower_technologies, through: :hierarckies, source: :upper_technologyaaa

  has_many :lower_hierarckies,class_name: "Hierarcky", foreign_key: :lower_technology_id
  has_many :upper_technologies, through: :lower_hierarckies, source: :technology

end
