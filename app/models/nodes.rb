require 'csv'

class Nodes
  attr_reader :file_path

  def initialize(opts={})
    @file_path = opts[:file_path]
  end

  def all
    _hash_data
  end

  # lookup time: O(log n)
  def find_parent(child_id)
    _hash_data[child_id]
  end

  def all_parents(child_id)
    _all_nodes = []
    _parent_id = find_parent(child_id)
    while _parent_id != nil # stop at the root node
      _all_nodes.push(_parent_id)
      _parent_id = find_parent(_parent_id)
    end
    _all_nodes
  end

  private

  def _hash_data
    @__hash_data ||= _csv_data.to_h
  end

  def _csv_data
    CSV.read(file_path)
  end
end
