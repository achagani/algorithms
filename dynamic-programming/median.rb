# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Float}
def find_median_sorted_arrays(nums1, nums2)
  # puts "n1: #{nums2.length}"
  l = nums1.length + nums2.length
  # puts "l: #{l}"
  q = Array.new
  d = (l / 2)
  # puts "d: #{d}"
  (0..d).each do |x|

    if nums1.empty?
      q.push(nums2.shift)
    elsif nums2.empty?
      q.push(nums1.shift)
    elsif nums1.first < nums2.first
      n = nums1.shift
      # puts "n1: #{n}"
      q.push(n)
    else
      n = nums2.shift
      # puts "n2: #{n}"
      q.push(n)
    end
    # if l % 2 > 0
    # end
  end

  # puts q.join(',')

  if l % 2 != 0
    return q.last
  else
    return (q[q.length - 2] + q[q.length - 1]) / 2.0
  end
end

puts find_median_sorted_arrays([1, 2], [3, 4])
puts find_median_sorted_arrays([1, 3], [2])
puts find_median_sorted_arrays([], [2, 3])

# 4 / 2 = 2
# 3 / 2 = 1
