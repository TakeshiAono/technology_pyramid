class Technology < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }

  has_many :links, dependent: :destroy
  has_many :hierarckies, dependent: :destroy
  has_many :lower_hierarckies, class_name: 'Hierarcky', foreign_key: :lower_technology_id, dependent: :destroy
  has_many :lower_technologies, through: :hierarckies, source: :upper_technology
  has_many :upper_technologies, through: :lower_hierarckies, source: :technology
  belongs_to :work

  after_create_commit :create_default_position

  accepts_nested_attributes_for :hierarckies,
  reject_if: proc {
    |attributes| attributes['lower_technology_id'].blank?
  },
  allow_destroy: true

  def create_default_position
    TechnologyPosition.create!(top_technology_id: id, target_technology_id: id)
  rescue => e
    Rails.logger.error("Error: #{e}")
  end

  def get_technologies_and_hierarckies
    query = <<~SQL
      WITH
        -- 子テクノロジーのみを芋づる式に取得している
        RECURSIVE
          pyramid_technologies AS (
            SELECT
              h.technology_id AS upper_tech_id,
              h.lower_technology_id AS current_tech_id,
              1 AS layer
            FROM hierarckies h
            WHERE h.technology_id = :top_technology_id -- 最上位のテクノロジーidが入力される

            UNION ALL

            -- 前段のレコードの子テクノロジーidを親とする子要素をレコードとして追加する
            SELECT
              h2.technology_id AS upper_tech_id,
              h2.lower_technology_id AS current_tech_id,
              pt.layer + 1
            FROM hierarckies h2
            JOIN pyramid_technologies pt ON h2.technology_id = pt.current_tech_id
          ),

        top_technology AS (
          SELECT
            NULL::bigint AS upper_tech_id,
            t.id AS current_tech_id,
            t.name AS current_tech_name,
            0 AS current_layer,
            t.description
          FROM technologies t
          WHERE id = :top_technology_id
        ),

        technology_hierarckies AS
          -- 子と親の情報がセットになったレコードを取得
          (
            SELECT
              pt.upper_tech_id,
              pt.current_tech_id,
              t.name AS current_tech_name,
              pt.layer AS current_layer,
              t.description
            FROM pyramid_technologies pt
            JOIN technologies t ON pt.current_tech_id = t.id

            UNION ALL
            -- 最上位用のレコードを追加
            SELECT
              tt.upper_tech_id,
              tt.current_tech_id,
              tt.current_tech_name,
              tt.current_layer,
              tt.description
            FROM top_technology tt
            WHERE tt.current_tech_id = :top_technology_id
          )

      SELECT
        upper_tech_id,
        current_tech_id,
        current_tech_name,
        current_layer,
        top_technology_id,
        x_pos,
        y_pos,
        description,
        id AS tech_pos_id
      FROM technology_hierarckies th
      JOIN technology_positions tp ON th.current_tech_id = tp.target_technology_id
      WHERE tp.top_technology_id = :top_technology_id;
    SQL

    sanitized_sql = ActiveRecord::Base.send(:sanitize_sql_array, [query, {top_technology_id: id}])
    ActiveRecord::Base.connection.execute(sanitized_sql).to_a
  end
end
