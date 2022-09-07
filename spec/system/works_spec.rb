require 'rails_helper'

RSpec.describe "Works", type: :system do
  describe 'CRUD機能' do
    before do
      FactoryBot.create(:work)
      visit new_user_session_path
      click_link 'ゲストログイン（閲覧用）'
      visit works_path
    end
    
    context '新規ワークを作成した場合' do
      example '新しいワークレコードがワーク一覧ページで表示される' do
        click_link '新規ワーク作成'
        fill_in "work[title]", with: 'example'
        click_on 'commit'
        expect(page).to have_content "example"
      end
    end

    context 'ワークの詳細確認をした場合' do
      example 'showページで表示される' do
        click_link '詳細'
        expect(page).to have_content "test"
      end
    end

    context 'ワークを編集した場合' do
      example '変更した内容がワーク一覧ページに反映される' do
        click_link '編集'
        fill_in "work[title]", with: 'change'
        click_on 'commit'
        expect(page).to have_content "change"
      end
    end

    context 'ワークを削除した場合' do
      example '削除したワークがワーク一覧ページから消えている' do
        click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "test"
      end
    end
  end
end
