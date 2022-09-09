require 'rails_helper'

RSpec.describe Hierarcky, type: :model do
  describe 'バリデーション機能' do
    context 'バリデーション成功の場合' do
      example 'technologissテーブルにレコード追加ができる' do
        hierarcky = FactoryBot.build(:hierarcky)
        expect(hierarcky).to be_valid
      end
    end
  end
end
