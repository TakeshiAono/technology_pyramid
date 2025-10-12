class Technology < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }

  has_many :links, dependent: :destroy
  has_many :hierarckies, dependent: :destroy
  has_many :lower_hierarckies, class_name: 'Hierarcky', foreign_key: :lower_technology_id, dependent: :destroy
  has_many :lower_technologies, through: :hierarckies, source: :upper_technology
  has_many :upper_technologies, through: :lower_hierarckies, source: :technology
  belongs_to :work

  accepts_nested_attributes_for :hierarckies,
  reject_if: proc {
    |attributes| attributes['lower_technology_id'].blank?
  },
  allow_destroy: true

  def get_technologies_and_hierarckies
    query = <<~SQL
    -- 子テクノロジーのみを芋づる式に取得している
      WITH
        RECURSIVE pyramid_relations AS (
          --　一番上の親はここでは取得せず本sqlの最後で追加している。
          SELECT h.lower_technology_id AS child_tech_id, 1 AS layer
          FROM hierarckies h
          WHERE h.technology_id = ?
          UNION ALL
          -- 前段のレコードの子テクノロジーidを親とする子要素をunionする
          SELECT h2.lower_technology_id AS child_tech_id, pr.layer + 1
          FROM hierarckies h2
          JOIN pyramid_relations pr ON h2.technology_id = pr.child_tech_id
        ),
        top_technology AS (SELECT * FROM technologies WHERE id = ?)

      -- 親と子がセットになったレコードを取得
      SELECT
        t.*,
        pr.layer,
        pr.child_tech_id
      FROM technologies t
      JOIN pyramid_relations pr ON t.id = pr.child_tech_id
      UNION ALL
      -- トップの親と子がセットになったレコードを取得
      SELECT
        t.*,
        0 AS layer,
        h.lower_technology_id AS child_tech_id
      FROM top_technology t
      -- 子要素ができたと時に初めてhierarckiesレコードが生成されるため
      -- 子要素が1つもないトップテクノロジーがあり得るため、inner join で消えないようleft outer joinを使用
      LEFT OUTER JOIN hierarckies AS h
      ON t.id = h.technology_id
    SQL

    sanitized_sql = ActiveRecord::Base.send(:sanitize_sql_array, [query, id, id])
    ActiveRecord::Base.connection.execute(sanitized_sql).to_a
  end
end
