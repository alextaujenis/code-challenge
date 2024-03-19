class Node < ApplicationRecord
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

  # HOW TO USE: all_children_ids(nil, node_ids)
  # 1. move the children to the parents collection
  # 2. find the children of the parents
  # 3. return all parents when there are no more children
  def self.all_children_ids(parent_ids = Bst.new, child_ids = [])
    # remove parent nodes that have been processed from the child nodes
    child_ids = child_ids - parent_ids.all
    # store the child ids in a unique hash
    parent_ids.insert(child_ids)
    # find the new child ids
    child_ids = Node.where(parent_id: child_ids).pluck(:id)
    if child_ids.empty?
      return parent_ids.all
    else
      all_children_ids(parent_ids, child_ids)
    end
  end
end
