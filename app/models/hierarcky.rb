class Hierarcky < ApplicationRecord
  # after_save :piramid_constructer_check
  # after_update :piramid_constructer_check
  # validates :lower_technology_id, exclusion: { in: :technology_id }
  # validates_exclusion_of :techonology, in: :lower_technology_id
  # puts self.technology_id
  # validates :lower_technology_id, if: :technology_id == :lower_technology_id

  belongs_to :technology
  belongs_to :upper_technology, class_name: "Technology", foreign_key: "lower_technology_id", optional: true

  # def piramid_constructer_check
  #   if lower_technology_id.present?
  #     self.technology
  #   end
  #   throw(:abort)
  # end

end
