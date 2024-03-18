class Bst
  def initialize(data=[])
    @_data = {}
    data.each { |d| @_data[d] = nil }
  end

  # lookup time: O(log n)
  def include?(item)
    @_data.key?(item)
  end
end
