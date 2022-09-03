require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    FactoryBot.create(:user)
  end

  describe 'アカウント登録機能' do
    context 'ユーザーがsign upした場合' do
      example '正常にsign upできる' do
        # visit new_user_registration_path
        # fill_in "user[name]", with: "test_user"
        # fill_in "user[email]", with: "testemail@gmail.com"
        # fill_in "user[password]", with: "testpassword"
        # fill_in "user[password_confirmation]", with: "testpassword"
        # click_on "commit"
        # expect(page).to have_content "test_user"
        # expect(page).to have_content "testemail@gmail.com"
      end

      example 'マイページに遷移できる' do
      end
    end

    context 'emailが他のユーザーと重複した場合' do
      example 'バリデーションエラーが出力される' do
      end

      example 'マイページ遷移しない' do
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
