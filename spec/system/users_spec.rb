require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'アカウント登録機能' do
    def sign_up_form_input(name: "example", email: "guest@example.com", password: "example", password_confirmation: "example")
      visit new_user_registration_path
      fill_in "user[name]", with: name
      fill_in "user[email]", with: email
      fill_in "user[password]", with: password
      fill_in "user[password_confirmation]", with: password_confirmation
      click_on "commit"
    end
    context 'sign upした場合' do
      context '入力値が不適でsign upした場合' do
        example 'nameが空の場合、エラーメッセージが表示され、マイページに遷移しない' do
          visit new_user_registration_path
          sign_up_form_input(name: nil)
          expect(page).to have_content "入力してください"
          expect(current_path).not_to eq my_pages_path
        end

        example 'nameが10文字以上の場合、エラーメッセージが表示され、マイページに遷移しない' do
          sign_up_form_input(name: "a"*11)
          expect(page).to have_content "文字以内で入力してください"
          expect(current_path).not_to eq my_pages_path
        end

        example 'emailが空の場合、エラーメッセージが表示され、マイページに遷移しない' do
          sign_up_form_input(email: nil)
          expect(page).to have_content "入力してください"
          expect(current_path).not_to eq my_pages_path
        end

        example 'emailが60文字以上の場合、エラーメッセージが表示され、マイページに遷移しない' do
          sign_up_form_input(email: "a"*49+"@example.com")
          expect(page).to have_content "文字以内で入力してください"
          expect(current_path).not_to eq my_pages_path
        end

        example 'emailがフォーマットに従ってない場合、エラーメッセージが表示され、マイページに遷移しない' do
          sign_up_form_input(email: "example")
          expect(current_path).to eq "/users/sign_up"
          expect(current_path).not_to eq my_pages_path
        end

        example 'passwordとpassword_confirmが一致しない場合、エラーメッセージが表示され、マイページに遷移しない' do
          sign_up_form_input(password: "example", password_confirmation: "examplea")
          expect(page).to have_content "パスワードの入力が一致しません"
          expect(current_path).not_to eq my_pages_path
        end
      end

      context '入力値が正常な時' do
        example 'マイページに遷移できる' do
          sign_up_form_input
          expect(current_path).to eq my_pages_path
        end
      end
    end
  end

  describe 'ログイン機能' do
    describe 'アクセス禁止' do
      context '登録ユーザー以外の場合' do
        example 'マイページにアクセスさせない' do
          visit my_pages_path
          expect(current_path).not_to eq my_pages_path
        end
  
        example 'ワークページにアクセスさせない' do
          visit works_path
          expect(current_path).not_to eq works_path
        end
  
        example 'テクノロジーページにアクセスさせない' do
          visit technologies_path
          expect(current_path).not_to eq technologies_path
        end
  
        example 'リンクページにアクセスさせない' do
          visit links_path
          expect(current_path).not_to eq links_path
        end
  
        example 'リンクページにアクセスさせない' do
          visit pyramids_path
          expect(current_path).not_to eq pyramids_path
        end
      end
    end

    describe 'アクセス許可' do
      let!(:user){FactoryBot.create(:user)}
      context '登録ユーザー以外の場合' do
        example 'loginページにクセスできる' do
          visit new_user_session_path
          expect(current_path).to eq new_user_session_path
        end
  
        example 'sign upページにクセスできる' do
          visit new_user_registration_path
          expect(current_path).to eq new_user_registration_path
        end
      end

      context '管理者ゲストユーザーがログインした場合' do
        example '正常にログインできる' do
          visit new_user_session_path
          click_link 'ゲストログイン（管理者用）'
          expect(current_path).to eq my_pages_path
        end
      end

      context '一般ユーザゲストユーザーがログインした場合' do
        example '正常にログインできる' do
          visit new_user_session_path
          click_link 'ゲストログイン（一般ユーザ用）'
          expect(current_path).to eq my_pages_path
        end
      end

      context '登録済のユーザーがログインした場合' do
        example '正常にログインできる' do
          visit new_user_session_path
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
          click_on 'commit'
          expect(current_path).to eq my_pages_path
        end
      end
    end
  end

  describe '管理画面機能' do
    let!(:not_admin_user){FactoryBot.create(:user, email: 'not_admin@example.com', admin: false)}
    let!(:admin_user){FactoryBot.create(:user)}
    context '管理者ユーザーの場合' do
      example '管理画面に遷移できる' do
        visit new_user_session_path
        fill_in 'user[email]', with: admin_user.email
        fill_in 'user[password]', with: admin_user.password
        click_on 'commit'
        visit rails_admin_path
        expect(current_path).to eq rails_admin_path
      end
    end
  end
end
