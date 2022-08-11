class Pyramid < ApplicationRecord
  has_many :link_access_counters
  has_many :technologies
  belongs_to :work
end
