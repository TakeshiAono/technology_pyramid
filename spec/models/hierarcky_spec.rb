require 'rails_helper'

RSpec.describe Hierarcky, type: :model do
  describe 'バリデーション機能' do
    # context 'バリデーション失敗の場合' do
    #   example '存在しないtechnologyを参照している場合、validationエラーになる' do
    #     hierarcky = FactoryBot.build(:hierarcky)
    #     expect(hierarcky).to be_valid
    #   end

      # example 'technology_idとlower_technology_idが同値の場合、validationエラーになる' do
      #   hierarcky = FactoryBot.build(:hierarcky, technology_id: 1, lower_technology_id: 1)
      #   byebug
      #   expect(hierarcky).to be_invalid
      # end
    # end

    context 'バリデーション成功の場合' do
      example 'technologissテーブルにレコード追加ができる' do
        hierarcky = FactoryBot.build(:hierarcky)
        expect(hierarcky).to be_valid
      end
    end
  end
end
