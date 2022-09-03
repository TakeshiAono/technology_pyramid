require 'rails_helper'

RSpec.describe Users, type: :model do
  describe 'バリデーション機能' do
    context 'バリデーション成功の場合' do
      example 'ユーザーテーブルに保存できる' do
      end
    end
    context 'バリデーション失敗の場合' do
      example '名前が空の場合、validationエラーになる' do
      end
      example '名前が10文字以上の場合、validationエラーになる' do
      end
      example 'nameが空の場合、validationエラーになる' do
      end
      example 'nameが10文字以上の場合、validationエラーになる' do
      end
      example 'emailが空の場合、validationエラーになる' do
      end
      example 'emailが30文字以上の場合、validationエラーになる' do
      end
      example 'emailがフォーマットに従ってない場合、validationエラーになる' do
      end
      example 'passwordとpassword_confirmが一致しない場合、validationエラーになる' do
      end
    end
  end
end
