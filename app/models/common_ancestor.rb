class CommonAncestor
  attr_reader :node_a, :node_b, :root_id, :lowest_common_ancestor, :depth

  def initialize(node_a:, node_b:)
    @node_a = node_a
    @node_b = node_b
    @root_id = nil
    @lowest_common_ancestor = nil
    @depth = nil
  end

  def run
    return unless node_a.present? && node_b.present?
    if node_a == node_b
      compute_single_node
    else
      compute_multi_node
    end
  end

  def data
    { root_id:, lowest_common_ancestor:, depth: }
  end

  private

  def compute_single_node
    node_a_ancestors = node_a.all_parent_ids
    @lowest_common_ancestor = node_a.id
    @depth = node_a_ancestors.length + 1
    @root_id = node_a_ancestors.last
  end

  def compute_multi_node
    # get the ancestor list for node_a
    node_a_ancestors = node_a.all_parent_ids
    # create a ruby set for optimal lookup
    node_a_ancestors_set = Set.new(node_a_ancestors)
    # walk backwards through ancestor list for node_b
    node_b_parent = node_b
    while node_b_parent.present? # stop at the root node
      # exit condition: the current (node_b) parent is in the ancestor list for node_a
      if node_a_ancestors_set.include?(node_b_parent.id) # optimized: O(log n)
        @lowest_common_ancestor = node_b_parent.id
        @root_id = node_a_ancestors.last
        @depth = node_a_ancestors.length - node_a_ancestors.index(node_b_parent.id) # find the (reversed) tree depth
        break
      end
      # find the next parent
      node_b_parent = node_b_parent.parent_node
    end
  end
end
