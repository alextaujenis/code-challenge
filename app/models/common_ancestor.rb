class CommonAncestor
  attr_reader :nodes, :node_a, :node_b, :root_id, :lowest_common_ancestor, :depth

  def initialize(opts={})
    @nodes = opts[:nodes]
    @node_a = opts[:node_a].to_s
    @node_b = opts[:node_b].to_s
    @root_id = nil
    @lowest_common_ancestor = nil
    @depth = nil
  end

  def run
    # get the ancestor list for node_a
    _node_a_ancestors = nodes.all_parents(node_a)
    # walk backwards through ancestor list for node_b
    _node_b_parent_id = node_b
    while _node_b_parent_id != nil # stop at the root node
      # exit condition: the current (node_b) parent is in the ancestor list for node_a
      if _node_a_ancestors.include?(_node_b_parent_id)
        @root_id = _node_a_ancestors.last
        @lowest_common_ancestor = _node_b_parent_id
        @depth = _node_a_ancestors.reverse.find_index(lowest_common_ancestor) + 1
        break
      end
      # find the next parent id
      _node_b_parent_id = nodes.find_parent(_node_b_parent_id)
    end
  end

  def data
    {
      root_id: root_id.to_i,
      lowest_common_ancestor: lowest_common_ancestor.to_i,
      depth: depth
    }
  end
end
