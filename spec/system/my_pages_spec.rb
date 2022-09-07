require 'rails_helper'

RSpec.describe "MyPages", type: :system do
  describe 'ワーク検索機能' do
    context '検索に該当するものがあった場合' do
      before do
        FactoryBot.create(:work)
        visit new_user_session_path
        click_link 'ゲストログイン（閲覧用）'
      end
      example 'ワーク名を表示する' do
        visit my_pages_path
        fill_in 'q[title_cont]', with: 'test'
        click_on 'commit'
        expect(page).to have_content "test"
      end
    end
  end
end
