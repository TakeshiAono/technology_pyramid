require 'rails_helper'

RSpec.describe 'Links', type: :system do
  describe 'CRUD機能' do
    let!(:link) { FactoryBot.create(:link) }
    let!(:second_link) { FactoryBot.create(:link, technology_id: link.technology.id) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: User.first.email
      fill_in 'user[password]', with: 'example'
      click_on 'commit'
      visit work_technology_links_path(link.technology.work.id, link.technology.id)
    end

    after do
      visit destroy_user_session_path
    end

    context '新規リンクを作成した場合' do
      example '新しいリンクレコードがリンク一覧ページで表示される' do
        click_on '新規リンク作成'
        fill_in 'link[title]', with: 'example'
        click_on 'commit'
        expect(page).to have_content 'example'
      end
    end

    context 'リンクの詳細確認をした場合' do
      example 'showページで表示される' do
        find_all('tr')[1].find('.btn-secondary').click
        expect(page).to have_content link.title
      end
    end

    context 'リンクを編集した場合' do
      example '変更した内容がリンク一覧ページに反映される' do
        find_all('tr')[1].find('.btn-warning').click
        fill_in 'link[title]', with: 'change'
        click_on 'commit'
        expect(page).to have_content 'change'
      end
    end

    context 'リンクを削除した場合' do
      example '削除したリンクがリンク一覧ページから消えている' do
        page.accept_confirm do
          find_all('tr')[1].find('.btn-danger').click
        end
        expect(page).not_to have_content link.title
      end
    end
  end

  describe 'いいね機能' do
    let!(:link) { FactoryBot.create(:link) }
    let!(:second_link) { FactoryBot.create(:link, technology_id: link.technology.id) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: User.first.email
      fill_in 'user[password]', with: 'example'
      click_on 'commit'
      visit work_technology_links_path(link.technology.work.id, link.technology.id)
    end

    after do
      visit destroy_user_session_path
    end

    context '該当記事のいいねボタンを押した場合' do
      example 'いいねが未押下の場合いいねカウントが増える' do
        find_all('.fa-thumbs-up').first.click
        sleep(0.5)
        visit work_technology_links_path(link.technology.work.id, link.technology.id)
        expect(all('.good-counter')[0].text).to eq "1"
      end

      example 'いいねが押下済の場合いいねカウントが減る' do
        find_all('.fa-thumbs-up').first.click
        visit work_technology_links_path(link.technology.work.id, link.technology.id)
        sleep(0.5)
        find_all('.fa-thumbs-up').first.click
        visit work_technology_links_path(link.technology.work.id, link.technology.id)
        sleep(0.5)
        expect(all('.good-counter')[0].text).to eq "0"
      end
    end
  end
end
