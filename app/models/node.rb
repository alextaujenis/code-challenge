class Node < ApplicationRecord
  belongs_to :parent_node, class_name: 'Node', foreign_key: 'parent_id', optional: true
  has_and_belongs_to_many :birds

  def all_parents
    Node.find(all_parent_ids)
  end

  def all_parent_ids
    query = <<-SQL
      WITH Parents AS (
        -- initialize
        SELECT id, parent_id
        FROM nodes
        WHERE id = #{parent_id}
        UNION
        -- recursion
        SELECT n.id, n.parent_id
        FROM nodes n INNER JOIN Parents p
        ON n.id = p.parent_id
      ) SELECT id FROM Parents
    SQL
    Node.sql_ids(query)
  end

  def self.all_children(node_ids=[])
    Node.find(self.all_children_ids(node_ids))
  end

  def self.all_children_ids(node_ids=[])
    sanitized_ids = node_ids.map(&:to_i).join(",")
    query = <<-SQL
      WITH Children AS (
        -- initialize
        SELECT DISTINCT id, parent_id
        FROM nodes
        WHERE parent_id IN (#{sanitized_ids})
        UNION
        -- recursion
        SELECT DISTINCT n.id, n.parent_id
        FROM nodes n INNER JOIN Children c
        ON n.parent_id = c.id
      ) SELECT id FROM Children
    SQL
    sql_ids(query)
  end

  private

  def self.sql_ids(query)
    ActiveRecord::Base.connection.execute(query).map { |n| n["id"] }
  end
end
