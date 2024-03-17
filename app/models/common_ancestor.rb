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
    # no op
  end

  def data
    {
      root_id: root_id,
      lowest_common_ancestor: lowest_common_ancestor,
      depth: depth
    }
  end
end
