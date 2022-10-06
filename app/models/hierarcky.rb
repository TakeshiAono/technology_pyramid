class SelfReferenceValidator < ActiveModel::Validator
  def validate(record)
    if record.technology_id == record.lower_technology_id
      record.errors.add :lower_technology_id, "自分自身を下位技術として選択することはできません。"
    end
  end
end

class CircularReferencingPyramidsValidator < ActiveModel::Validator
  def validate(record)
    lower_technology_pyramid_components = []
    before_exec_technologies = []
    output_technologies = []

    if record.technology_id

      before_exec_technologies = [Technology.find(record.lower_technology_id)] #if record.technology_id
      
      while true
        lower_technology_pyramid_components += before_exec_technologies
        before_exec_technologies.each {|technology| output_technologies += technology.lower_technologies}
        before_exec_technologies.clear
        before_exec_technologies += output_technologies
        break if output_technologies.length == 0
        output_technologies.clear
      end
      duplication_check = lower_technology_pyramid_components.include?(Technology.find(record.technology_id))
      if duplication_check == true
        record.errors.add :lower_technologies, "循環参照となるためその下位技術は選択することはできません。"
      end
    end
  end
end

class Hierarcky < ApplicationRecord
  include ActiveModel::Validations
  validates_with SelfReferenceValidator
  validates_with CircularReferencingPyramidsValidator
  
  belongs_to :technology
  belongs_to :upper_technology, class_name: "Technology", foreign_key: "lower_technology_id"
end
