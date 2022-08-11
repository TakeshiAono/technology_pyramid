class Pyramid < ApplicationRecord
  has_many :link_access_counters
  has_many :technologies
  has_many :circulations
  belongs_to :work
end
