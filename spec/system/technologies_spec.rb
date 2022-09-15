require 'rails_helper'

RSpec.describe "Technologies", type: :system do
  describe 'CRUD機能' do
    before do
      FactoryBot.create(:technology)
      visit new_user_session_path
      click_link 'ゲストログイン（管理者用）'
      visit technologies_path(Work.first)
    end
    
    context '新規テクノロジーを作成した場合' do
      example '新しいテクノロジーレコードがテクノロジー一覧ページで表示される' do
        click_link '新規テクノロジー作成'
        fill_in "technology[name]", with: 'example'
        click_on 'commit'
        expect(page).to have_content "example"
      end
    end

    context 'テクノロジーの詳細確認をした場合' do
      example 'showページで表示される' do
        click_link '詳細'
        expect(page).to have_content "test_tech"
      end
    end

    context 'テクノロジーを編集した場合' do
      example '変更した内容がテクノロジー一覧ページに反映される' do
        click_link '編集'
        fill_in "technology[name]", with: 'change'
        click_on 'commit'
        expect(page).to have_content "change"
      end
    end

    context 'テクノロジーを削除した場合' do
      example '削除したテクノロジーがテクノロジー一覧ページから消えている' do
        click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content "test_tech"
      end
    end
  end
end
