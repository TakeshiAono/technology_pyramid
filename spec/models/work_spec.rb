require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'バリデーション機能' do
    context 'バリデーション失敗の場合' do
      example 'titleが空の場合、validationエラーになる' do
        work = FactoryBot.build(:work, title: nil)
        expect(work).to be_invalid
      end

      example 'titleが11文字以上場合、validationエラーになる' do
        work = FactoryBot.build(:work, title: 'a' * 11)
        expect(work).to be_invalid
      end
    end

    context 'バリデーション成功の場合' do
      example 'worksテーブルにレコード追加ができる' do
        work = FactoryBot.build(:work)
        expect(work).to be_valid
      end
    end
  end
end
