require 'rails_helper'

RSpec.describe "Searches", type: :system do
  describe '検索機能' do
    before do
      FactoryBot.create(:work, title: "rails")
      visit new_user_session_path
      click_link 'ゲストログイン（管理者用）'
    end
    
    context '合致しないキーワードで検索した場合' do
      example '「検索キーワードに合致しませんでした」というnoticeが表示される' do
        fill_in "q[title_cont]", with: 'testtesttest'
        click_on 'commit'
        expect(page).to have_content "検索キーワードに合致しませんでした"
      end
    end

    context '未入力で検索した場合' do
      before do
        visit my_pages_path
        click_on 'commit'
      end

      example '「キーワードを入力してください」というnoticeが表示される' do
        expect(page).to have_content "検索キーワードを入力してください"
      end
    end

    context '存在するタイトル名で検索した場合' do
      example '変更した内容がテクノロジー一覧ページに反映される' do
        visit my_pages_path
        fill_in "q[title_cont]", with: 'rails'
        click_on 'commit'
        expect(page).to have_content "example"
      end
    end
  end
end