require 'rails_helper'

RSpec.describe Technology, type: :model do
  describe 'バリデーション機能' do
    context 'バリデーション失敗の場合' do
      example 'nameが空の場合、validationエラーになる' do
        technology = FactoryBot.build(:technology, name: nil)
        expect(technology).to be_invalid
      end

      example 'titleが11文字以上場合、validationエラーになる' do
        technology = FactoryBot.build(:technology, name: 'a' * 11)
        expect(technology).to be_invalid
      end
    end

    context 'バリデーション成功の場合' do
      example 'technologissテーブルにレコード追加ができる' do
        technology = FactoryBot.build(:technology)
        expect(technology).to be_valid
      end
    end
  end
end
