# This allows O(log n) lookup time for array.include?
# This should be converted to a Ruby "set" instead
class Bst
  def initialize(data=[])
    @_data = {}
    insert(data)
  end

  # lookup time: O(log n)
  def include?(item)
    @_data.key?(item.to_i)
  end

  def insert(items)
    items.each { |item| @_data[item.to_i] = nil }
  end

  def all
    @_data.keys
  end
end
