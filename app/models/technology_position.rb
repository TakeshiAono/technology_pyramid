class TechnologyPosition < ApplicationRecord
  belongs_to :top_technology, class_name: "Technology"
  belongs_to :target_technology, class_name: "Technology"
end
