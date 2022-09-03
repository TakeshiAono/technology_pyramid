require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    FactoryBot.create(:user)
  end

  describe 'アカウント登録機能' do
    context 'sign upした場合' do
      context '入力値が正常な時' do
        example 'マイページに遷移できる' do
          # visit new_user_registration_path
          # fill_in "user[name]", with: "test_user"
          # fill_in "user[email]", with: "testemail@gmail.com"
          # fill_in "user[password]", with: "testpassword"
          # fill_in "user[password_confirmation]", with: "testpassword"
          # click_on "commit"
          # expect(page).to have_content "test_user"
          # expect(page).to have_content "testemail@gmail.com"
        end
      end
      context '入力値が不適でsign upした場合' do
        example 'nameが空の場合、エラーメッセージが表示される' do
        end
        example 'nameが10文字以上の場合、エラーメッセージが表示される' do
        end
        example 'emailが空の場合、エラーメッセージが表示される' do
        end
        example 'emailが30文字以上の場合、エラーメッセージが表示される' do
        end
        example 'emailがフォーマットに従ってない場合、エラーメッセージが表示される' do
        end
        example 'passwordとpassword_confirmが一致しない場合、エラーメッセージが表示される' do
        end
        example 'マイページに遷移しない' do
        end
      end
    end
  end

  describe 'ログイン機能' do
    context 'ゲストユーザーがログインした場合' do
      example '正常にログインできる' do
      end
    end

    context '一般ユーザーがログインした場合' do
      example '正常にログインできる' do
      end
    end

    context 'ユーザー以外がログインした場合' do
      example 'pyramid画面とリンク画面へのアクセスを許可する' do
      end

      example 'login画面に遷移させる' do
      end
    end

  end
end
