def merge(arr, l, m, r)
  l_arr = arr[l..m]
  r_arr = arr[m+1..r]

  n = l
  while !l_arr.empty? && !r_arr.empty?
    if l_arr[0] < r_arr[0]
      arr[n] = l_arr.shift
    else
      arr[n] = r_arr.shift
    end
    n += 1
  end

  if l_arr.empty?
    r_arr.each do |x|
      arr[n] = x
      n += 1
    end
  end

  if r_arr.empty?
    l_arr.each do |x|
      arr[n] = x
      n += 1
    end
  end

end

def _merge_sort(arr, l, r)
  if r-l > 0
    m = (l+r)/2
	_merge_sort(arr, l, m)
	_merge_sort(arr, m+1, r)
	merge(arr, l, m, r)
end
end

def merge_sort!(arr)
	_merge_sort(arr, 0, arr.length)	
end


a = [5, 1, 3, 6, 7, 8, 9]
merge_sort!(a)
print a
