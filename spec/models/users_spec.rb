require 'rails_helper'

RSpec.describe Users, type: :model do
  describe 'バリデーション機能' do
    let(:user) { FactoryBot.create(:user) }
    context 'バリデーション失敗の場合' do
      example 'nameが空の場合、validationエラーになる' do
        test_user = FactoryBot.build(:user, name: nil, email: 'guest@example.com', password: 'example',
                                            password_confirmation: 'example')
        expect(test_user).to be_invalid
      end

      example 'nameが10文字以上の場合、validationエラーになる' do
        test_user = FactoryBot.build(:user, name: 'a' * 11, email: 'guest@example.com', password: 'example',
                                            password_confirmation: 'example')
        expect(test_user).to be_invalid
      end

      example 'emailが空の場合、validationエラーになる' do
        test_user = FactoryBot.build(:user, name: 'example', email: nil, password: 'example',
                                            password_confirmation: 'example')
        expect(test_user).to be_invalid
      end

      example '他のemailと重複した場合、validationエラーになる' do
        test_user = FactoryBot.build(:user, name: 'example', email: user.email, password: 'example',
                                            password_confirmation: 'example')
        expect(test_user).to be_invalid
      end

      example 'emailがフォーマットに従ってない場合、validationエラーになる' do
        test_user = FactoryBot.build(:user, name: 'example', email: 'guestexample.com', password: 'example',
                                            password_confirmation: 'example')
        expect(test_user).to be_invalid
      end

      example 'emailが60文字以上の場合、validationエラーになる' do
        test_user = FactoryBot.build(:user, name: 'example', email: 'a' * 49 + '@example.com', password: 'example',
                                            password_confirmation: 'example')
        expect(test_user).to be_invalid
      end

      example 'passwordとpassword_confirmが一致しない場合、validationエラーになる' do
        test_user = FactoryBot.build(:user, name: 'example', email: 'guest@example.com', password: 'example',
                                            password_confirmation: 'examplea')
        expect(test_user).to be_invalid
      end
    end

    context 'バリデーション成功の場合' do
      example 'ユーザーテーブルに保存できる' do
        expect(User.find_by(email: user.email)).to eq(user)
      end
    end
  end
end
