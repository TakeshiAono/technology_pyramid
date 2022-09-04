require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'アカウント登録機能' do
    context 'sign upした場合' do
      context '入力値が不適でsign upした場合' do
        example 'nameが空の場合、エラーメッセージが表示され、マイページに遷移しない' do
          visit new_user_registration_path
          fill_in "user[name]", with: nil
          fill_in "user[email]", with: "guest@example.com"
          fill_in "user[password]", with: "example"
          fill_in "user[password_confirmation]", with: "example"
          click_on "commit"
          expect(page).to have_content "入力してください"
          expect(current_path).not_to eq my_pages_path
        end

        example 'nameが10文字以上の場合、エラーメッセージが表示され、マイページに遷移しない' do
          visit new_user_registration_path
          fill_in "user[name]", with: "a"*11
          fill_in "user[email]", with: "guest@example.com"
          fill_in "user[password]", with: "example"
          fill_in "user[password_confirmation]", with: "example"
          expect(current_path).not_to eq my_pages_path
          click_on "commit"
          expect(page).to have_content "文字以内で入力してください"
        end
        example 'emailが空の場合、エラーメッセージが表示され、マイページに遷移しない' do
          visit new_user_registration_path
          fill_in "user[name]", with: "example"
          fill_in "user[email]", with: nil
          fill_in "user[password]", with: "example"
          fill_in "user[password_confirmation]", with: "example"
          click_on "commit"
          expect(page).to have_content "入力してください"
          expect(current_path).not_to eq my_pages_path
        end
        example 'emailが30文字以上の場合、エラーメッセージが表示され、マイページに遷移しない' do
          visit new_user_registration_path
          fill_in "user[name]", with: "example"
          fill_in "user[email]", with: "a"*19+"@example.com"
          fill_in "user[password]", with: "example"
          fill_in "user[password_confirmation]", with: "example"
          click_on "commit"
          expect(page).to have_content "文字以内で入力してください"
          expect(current_path).not_to eq my_pages_path
        end
        example 'emailがフォーマットに従ってない場合、エラーメッセージが表示され、マイページに遷移しない' do
          visit new_user_registration_path
          fill_in "user[name]", with: "example"
          fill_in "user[email]", with: "example"
          fill_in "user[password]", with: "example"
          fill_in "user[password_confirmation]", with: "example"
          click_on "commit"
          expect(current_path).to eq "/users/sign_up"
          expect(current_path).not_to eq my_pages_path
        end
        example 'passwordとpassword_confirmが一致しない場合、エラーメッセージが表示され、マイページに遷移しない' do
          visit new_user_registration_path
          fill_in "user[name]", with: "example"
          fill_in "user[email]", with: "guest@example.com"
          fill_in "user[password]", with: "example"
          fill_in "user[password_confirmation]", with: "examplea"
          click_on "commit"
          expect(page).to have_content "パスワードの入力が一致しません"
          expect(current_path).not_to eq my_pages_path
        end
      end

      context '入力値が正常な時' do
        example 'マイページに遷移できる' do
          visit new_user_registration_path
          fill_in "user[name]", with: "example"
          fill_in "user[email]", with: "guest@example.com"
          fill_in "user[password]", with: "example"
          fill_in "user[password_confirmation]", with: "example"
          click_on "commit"
          expect(current_path).to eq my_pages_path
        end
      end
    end
  end

  describe 'ログイン機能' do
    context 'ユーザー以外がページにアクセスした場合' do
      example 'pyramid、リンク、loginページ以外へアクセスさせない' do
      end
      example 'pyramidページへ遷移させる' do
      end
      example 'リンクページへアクセスできる' do
      end
      example 'loginページにクセスできる' do
      end
    end
    context 'ゲストユーザーがログインした場合' do
      example '正常にログインできる' do
      end
    end
    context '一般ユーザーがログインした場合' do
      example '正常にログインできる' do
      end
    end
  end

  describe 'ゲストログイン機能' do
    example 'ゲストログインできる' do
    end
  end

  describe '管理画面機能' do
    context '管理者ユーザーの場合' do
      example '管理画面に遷移できる' do
      end
    end

    context '管理者ユーザーではない場合' do
      example '管理画面に遷移できない' do
      end
    end
  end

end
