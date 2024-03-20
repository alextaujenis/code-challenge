class CommonAncestor
  attr_reader :node_a, :node_b, :root_id, :lowest_common_ancestor, :depth

  def initialize(opts={})
    @node_a = opts[:node_a]
    @node_b = opts[:node_b]
    @root_id = nil
    @lowest_common_ancestor = nil
    @depth = nil
  end

  def run
    if node_a.present? && node_b.present?
      if node_a == node_b
        _compute_single_node
      else
        _compute_multi_node
      end
    end
  end

  def data
    {
      root_id: root_id,
      lowest_common_ancestor: lowest_common_ancestor,
      depth: depth
    }
  end

  private

  def _compute_single_node
    _node_a_ancestors = node_a.all_parents
    @lowest_common_ancestor = node_a.id
    @depth = _node_a_ancestors.length + 1
    @root_id = _node_a_ancestors.last.id
  end

  def _compute_multi_node
    # get the ancestor list for node_a
    _node_a_ancestors = node_a.all_parents
    # create a binary search tree for optimal lookup
    _node_a_ancestors_set = Set.new(_node_a_ancestors.map(&:id))
    # walk backwards through ancestor list for node_b
    _node_b_parent = node_b
    while _node_b_parent.present? # stop at the root node
      # exit condition: the current (node_b) parent is in the ancestor list for node_a
      if _node_a_ancestors_set.include?(_node_b_parent.id) # optimized: O(log n)
        @lowest_common_ancestor = _node_b_parent.id
        @root_id = _node_a_ancestors.last.id
        @depth = _node_a_ancestors.length - _node_a_ancestors.index(_node_b_parent) # find the (reversed) tree depth
        break
      end
      # find the next parent
      _node_b_parent = _node_b_parent.parent_node
    end
  end
end
