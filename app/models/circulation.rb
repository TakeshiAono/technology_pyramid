class Circulation < ApplicationRecord
  belongs_to :pyramid, optional: true
  belongs_to :technology, optional: true
end
