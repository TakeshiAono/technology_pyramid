require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
  end

  # describe 'ユーザ新規登録機能' do
  #   context '一般ユーザーがsign upした場合' do
  #     example '作成したユーザーが表示される' do
  #       visit new_user_registration_path
  #       fill_in "user[name]", with: "test_user"
  #       fill_in "user[email]", with: "testemail@gmail.com"
  #       fill_in "user[password]", with: "testpassword"
  #       fill_in "user[password_confirmation]", with: "testpassword"
  #       click_on "commit"
  #       expect(page).to have_content "test_user"
  #       expect(page).to have_content "testemail@gmail.com"
  #     end
  #   end
  # end

  describe 'ユーザー機能' do
    context 'ユーザーを新規作成した場合' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_registration_path 
        fill_in 'user[email]', with: 'test@test.com' 
        fill_in 'user[password]', with: 'password' 
        fill_in 'user[password_confirmation]', with: 'password' 
        click_button 'アカウント登録' 
        expect(page).to have_content 'アカウント登録が完了しました' 
      end 
    end 
    context '登録した情報でログインした場合' do
      it 'ログインができる' do
        visit new_user_session_path 
        fill_in 'user[email]', with: 'test1@test.com' 
        fill_in 'user[password]', with: '12345678' 
        click_button 'ログイン' 
        expect(page).to have_content 'ログインしました' 
      end 
    end
  end


end
