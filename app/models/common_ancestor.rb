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
    if node_a == node_b
      _compute_single_node
    elsif node_a != nil && node_b != nil
      _compute_multi_node
    end
  end

  def data
    {
      root_id: _to_i(root_id),
      lowest_common_ancestor: _to_i(lowest_common_ancestor),
      depth: depth
    }
  end

  private

  def _compute_single_node
    _node_a_ancestors = nodes.all_parents(node_a)
    @lowest_common_ancestor = node_a
    @depth = _node_a_ancestors.length + 1
    @root_id = _node_a_ancestors.last
  end

  def _compute_multi_node
    # get the ancestor list for node_a
    _node_a_ancestors = nodes.all_parents(node_a)
    # create a binary search tree for optimal lookup
    _node_a_ancestors_bst = Bst.new(_node_a_ancestors)
    # walk backwards through ancestor list for node_b
    _node_b_parent_id = node_b
    while _node_b_parent_id != nil # stop at the root node
      # exit condition: the current (node_b) parent is in the ancestor list for node_a
      if _node_a_ancestors_bst.include?(_node_b_parent_id) # optimized: O(log n)
        @lowest_common_ancestor = _node_b_parent_id
        @root_id = _node_a_ancestors.last
        @depth = _node_a_ancestors.length - _node_a_ancestors.index(lowest_common_ancestor) # find the (reversed) tree depth
        break
      end
      # find the next parent id
      _node_b_parent_id = nodes.find_parent(_node_b_parent_id)
    end
  end

  # don't convert nil to 0
  def _to_i(value)
    value.to_i if value != nil
  end
end
