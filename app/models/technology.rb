class Technology < ApplicationRecord
  belongs_to :work
  belongs_to :upper_tech, class_name: "Technology", foreign_key:"upper_technology"
end
