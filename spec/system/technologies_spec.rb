require 'rails_helper'

RSpec.describe 'Technologies', type: :system do
  describe 'CRUD機能' do
    let!(:technology) { FactoryBot.create(:technology) }
    let!(:second_technology) { FactoryBot.create(:second_technology, work_id: Work.first.id) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: User.first.email
      fill_in 'user[password]', with: 'example'
      click_on 'commit'
      visit work_technology_pyramids_path(Work.first, Work.first.technologies.first.id)
    end

    context '新規テクノロジーを作成した場合' do
      before do
        click_link '新規テクノロジー作成'
        fill_in 'technology[name]', with: 'example'
      end
      
      example '新しいテクノロジーレコードがテクノロジー一覧ページで表示される' do
        click_on 'commit'
        visit work_technologies_path(Work.first)
        expect(page).to have_content 'example'
      end

      example '任意のテクノロジーを下位テクノロジーとして紐づけができる' do
        select technology.name, from: 'technology[hierarckies_attributes][0][lower_technology_id]'
        click_on 'commit'
        expect(page).to have_content technology.name
      end
    end

    context 'テクノロジーの詳細確認をした場合' do
      example '作成済のテクノロジーをshowページで確認できる' do
        visit work_technologies_path(Work.first)
        all('tbody tr')[0].find('.btn-secondary').click
        expect(page).to have_content 'test_tech1'
      end
    end

    context 'テクノロジーを編集した場合' do
      before do
        visit edit_work_technology_path(Work.first.id, Work.first.technologies.first.id)
      end

      context '下位テクノロジーを編集する場合' do
        before do
          select 'test_tech2', from: 'technology[hierarckies_attributes][0][lower_technology_id]'
          click_on 'commit'
        end

        example '任意のテクノロジーを下位テクノロジーとして紐づけができる' do
          expect(page).to have_content 'test_tech2'
        end

        example '任意の下位テクノロジーとの紐づけを解除できる' do
          visit work_technologies_path(Work.first.id)
          all('.btn-danger').first.click
          page.driver.browser.switch_to.alert.accept
          expect(page).not_to have_content 'test_tech1'
        end
      end

      example '変更した内容がテクノロジー一覧ページに反映される' do
        fill_in 'technology[name]', with: 'change'
        click_on 'commit'
        expect(page).to have_content 'change'
      end
    end

    context 'テクノロジーを削除した場合' do
      example '削除したテクノロジーがテクノロジー一覧ページから消えている' do
        visit work_technologies_path(Work.first.id)
        all('tbody tr')[0].all('td')[6].click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'test_tech1'
      end
    end
  end
end
