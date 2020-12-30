require_relative "min_heap"

# This method uses a heap to sort an array.
# Time Complexity:  O(nlogn)
# Space Complexity: O(n)
def heapsort(list)
  return list if list.length <= 1

  # create heap
  heap = MinHeap.new
  list.each do |element|
    heap.add(element, element)
  end

  # sort list by pulling off item from heap
  # and replacing current list indices
  i = 0
  while i < list.length
    list[i] = heap.remove
    i += 1
  end

  return list
end