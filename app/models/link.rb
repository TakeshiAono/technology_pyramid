class Link < ApplicationRecord
  has_many :link_access_counters, dependent: :destroy
  belongs_to :technology
end
