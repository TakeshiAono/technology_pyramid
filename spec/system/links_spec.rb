require 'rails_helper'

RSpec.describe "Links", type: :system do
  describe 'CRUD機能' do
    before do
      FactoryBot.create(:link)
      visit new_user_session_path
      click_link 'ゲストログイン（管理者用）'
      visit links_path(Technology.first)
    end
    
    context '新規リンクを作成した場合' do
      example '新しいリンクレコードがリンク一覧ページで表示される' do
        click_link '新規リンク作成'
        fill_in "link[title]", with: 'example'
        click_on 'commit'
        expect(page).to have_content "example"
      end
    end

    context 'リンクの詳細確認をした場合' do
      example 'showページで表示される' do
        click_link '詳細'
        expect(page).to have_content "test"
      end
    end

    context 'リンクを編集した場合' do
      example '変更した内容がリンク一覧ページに反映される' do
        click_link '編集'
        fill_in "link[title]", with: 'change'
        click_on 'commit'
        expect(page).to have_content 'change'
      end
    end

    context 'リンクを削除した場合' do
      example '削除したリンクがリンク一覧ページから消えている' do
        page.accept_confirm do
          click_link '削除'
        end
        expect(page).not_to have_content 'link_test'
      end
    end
  end
end
