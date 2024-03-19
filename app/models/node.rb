class Node < ActiveRecord::Base
  belongs_to :parent_node, class_name: 'Node', foreign_key: 'parent_id', optional: true
  has_and_belongs_to_many :birds

  def all_parents
    _all_nodes = []
    _current_node = parent_node
    while _current_node != nil # stop at the root node
      _all_nodes.push(_current_node)
      _current_node = _current_node.parent_node
    end
    _all_nodes
  end
end
