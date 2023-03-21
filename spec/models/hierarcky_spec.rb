require 'rails_helper'

RSpec.describe Hierarcky, type: :model do
  describe 'バリデーション機能' do
    let!(:technology) { FactoryBot.create(:technology) }
    let!(:second_technology) { FactoryBot.create(:technology, name: 'test_tech2', work_id: Work.first.id) }
    let!(:third_technology) { FactoryBot.create(:technology, name: 'test_tech3', work_id: Work.first.id) }
    context 'バリデーション失敗の場合' do
      context '自身を参照している場合' do
        example 'hierarckiesテーブルにレコードを追加させない' do
          expect(Hierarcky.create(technology_id: technology.id, lower_technology_id: technology.id)).to be_invalid
        end
      end
      context '循環参照している場合' do
        example 'hierarckiesテーブルにレコードを追加させない' do
          Hierarcky.create(technology_id: technology.id, lower_technology_id: second_technology.id)
          Hierarcky.create(technology_id: second_technology.id, lower_technology_id: third_technology.id)
          expect(Hierarcky.create(technology_id: third_technology.id, lower_technology_id: technology.id)).to be_invalid
        end
      end
    end

    context 'バリデーション成功の場合' do
      example 'technologissテーブルにレコード追加ができる' do
        expect(Hierarcky.create(technology_id: technology.id, lower_technology_id: second_technology.id)).to be_valid
      end
    end
  end
end
