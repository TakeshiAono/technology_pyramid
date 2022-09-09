class Hierarcky < ApplicationRecord
  belongs_to :technology
  belongs_to :upper_technology, class_name: "Technology", foreign_key: "lower_technology_id", optional: true
end
