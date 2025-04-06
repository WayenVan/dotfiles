def pivot_sort(arr):
    """Sort an array using quicksort (pivot sort) algorithm."""
    if len(arr) <= 1:
        return arr
    
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    return pivot_sort(left) + middle + pivot_sort(right)

if __name__ == "__main__":
    test_array = [3, 6, 8, 10, 1, 2, 1]
    print("Original array:", test_array)
    sorted_array = pivot_sort(test_array)
    print("Sorted array:", sorted_array)
#

