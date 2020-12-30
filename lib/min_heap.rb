class HeapNode
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class MinHeap

  def initialize
    @store = []
  end

  # This method adds a HeapNode instance to the heap
  # Time Complexity: O(logn), worst case we have to swap through each level of a balanced tree
  #                           meaning the height of the tree which is logn where n is the number
  #                           of nodes in our tree
  # Space Complexity: O(logn), due to the recursive calls through the heap_up helper method
  def add(key, value = key)
    # insert new node to the bottom of the heap 
    # by placing it at the end of the array
    @store.push(HeapNode.new(key, value))

    heap_up(@store.length - 1) if @store.length > 1      
  end

  # This method removes and returns an element from the heap
  #   maintaining the heap structure
  # Time Complexity: O(logn) since worst case we have to go through each level, 
  # n being number of nodes in the heap
  # Space Complexity: O(1) since not using recursion
  def remove()
    return if @store.empty?
    
    # swap last item in heap with smallest value
    swap(0, -1)

    # remove smallest value
    removedNode = @store.pop

    # maintain heap structure
    heap_down() if @store.length > 1
    
    return removedNode.value
  end


  # Used for Testing
  def to_s
    return "[]" if @store.empty?

    output = "["
    (@store.length - 1).times do |index|
      output += @store[index].value + ", "
    end

    output += @store.last.value + "]"
      
    return output
  end

  # This method returns true if the heap is empty
  # Time complexity: O(1)
  # Space complexity: O(1)
  def empty?
    return true if @store.length == 0
  end

  private

  # This helper method takes an index and
  #  moves it up the heap, if it is less than it's parent node.
  #  It could be **very** helpful for the add method.
  # Time complexity: O(logn)
  # Space complexity: O(logn), n is halved with each recursive call
  def heap_up(index)
    # base case to exit recursion
    return if index == 0
    
    parentIndex = (index - 1) / 2

    if @store[parentIndex].key > @store[index].key
      swap(index, parentIndex)
      heap_up(parentIndex)
    end
  end

  # This helper method takes an index and 
  #  moves it up the heap if it's smaller
  #  than it's parent node.
  def heap_down(index=0)
    return if @store.empty?

    while ((2 * index) + 1) < @store.length # so long as we have a left child, continue to swap
      rightIndex = (2 * index) + 2
      leftIndex = (2 * index) + 1
      smallerIndex = leftIndex
      if (rightIndex < @store.length) && (@store[rightIndex].key < @store[leftIndex].key)
        smallerIndex = rightIndex
      end

      if @store[index].key < @store[smallerIndex].key
        break
      else
        swap(index, smallerIndex)
      end
      index = smallerIndex
    end
  end


  # If you want a swap method... you're welcome
  def swap(index_1, index_2)
    temp = @store[index_1]
    @store[index_1] = @store[index_2]
    @store[index_2] = temp
  end
end