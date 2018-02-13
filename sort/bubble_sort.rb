def bubble_sort!(arr)
  if arr.nil?
    return nil
  end
  if arr.empty? || arr.length == 1
    return arr
  end


  changes = 1
  while changes != 0
    changes = 0
    i = 0
    j = 1
    while i < arr.length - 1
      if arr[j] < arr[i]
        swap = arr[i]
        arr[i] = arr[j]
        arr[j] = swap
        changes += 1
      end
      j += 1
      i += 1
    end
  end
end


a = [5, 1, 3, 6, 7]
bubble_sort!(a)
print a
