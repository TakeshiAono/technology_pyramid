class Hierarcky < ApplicationRecord
  # after_save :piramid_constructer_check
  # after_update :piramid_constructer_check
  belongs_to :technology
  belongs_to :upper_technology, class_name: "Technology", foreign_key: "lower_technology_id", optional: true

  # def piramid_constructer_check
  #   if lower_technology_id.present?
  #     self.technology
  #   end
  #   throw(:abort)
  # end

end
