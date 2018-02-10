def binary_search(original, arr, element):
    
    if len(original) == 0:
        return -1
    
    center = len(arr) / 2
    if element == arr[center]:
        return original.index(arr[center])
    elif len(arr) == 1:
        return - 1
    
    left_split = arr[0:center]  
    right_split = arr[center+1:len(arr)]
    
    if element < arr[center]: 
        #print("left_split: ", left_split)
        return binary_search(original, left_split, element)
    
    if element > arr[center]:
        #print("right_split: ", right_split)
        return binary_search(original, right_split, element)
    
    



arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print binary_search(arr, arr, 4)
print binary_search(arr, arr, 6)
print binary_search(arr, arr, 5)
print binary_search(arr, arr, 10)
print binary_search(arr, arr, -1)
print binary_search(arr, arr, 9)
print binary_search(arr, arr, 1)

print "-----------------------"


arr = [1, 2, 3, 9, 10]
print binary_search(arr, arr, 4)
print binary_search(arr, arr, 6)
print binary_search(arr, arr, 5)
print binary_search(arr, arr, 10)
print binary_search(arr, arr, -1)
print binary_search(arr, arr, 9)
print binary_search(arr, arr, 1)

print "-----------------------"


arr = [1]
print binary_search(arr, arr, 1)


print "-----------------------"


arr = []
print binary_search(arr, arr, 1)


arr = []
print binary_search(arr, arr, 1)



# # Binary Search
# 
# #   1.  Input param # 1 - sorted array of integers, param # 2 - target element X we are searching for
# #   2.  Compare X with the middle element.
# #   3.  If X matches with middle element, we return the mid index.
# #   4.  Else If X is greater than the mid element, then X can only lie in right half subarray after the mid element. So we recur for right half.
# #   5.  Else (X is smaller) recur for the left half.
# #   6.  If target is not found, return -1