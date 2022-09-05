require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'バリデーション機能' do
    context 'バリデーション失敗の場合' do
      example 'titleが空の場合、validationエラーになる' do
        link = FactoryBot.build(:link, title: nil)
        expect(link).to be_invalid
      end

      example 'titleが11文字以上場合、validationエラーになる' do
        link = FactoryBot.build(:link, title: "a"*21)
        expect(link).to be_invalid
      end
    end

    context 'バリデーション成功の場合' do
      example 'technologissテーブルにレコード追加ができる' do
        link = FactoryBot.build(:link)
        expect(link).to be_valid
      end
    end
  end
end
