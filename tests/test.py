def pivot_sort(arr):
    """
    Implementation of QuickSort using pivot sorting.

    Args:
        arr: A list of comparable elements to be sorted

    Returns:
        A new sorted list
    """
    if len(arr) <= 1:
        return arr

    # Choose pivot (using the middle element to avoid worst-case on already sorted arrays)
    pivot_idx = len(arr) // 2
    pivot = arr[pivot_idx]

    # Partition the array
    left = [x for i, x in enumerate(arr) if x < pivot and i != pivot_idx]
    middle = [x for x in arr if x == pivot]
    right = [x for i, x in enumerate(arr) if x > pivot and i != pivot_idx]

    # Recursively sort the partitions and combine
    return pivot_sort(left) + middle + pivot_sort(right)


# Example usage
if __name__ == "__main__":
    test_array = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    sorted_array = pivot_sort(test_array)
    print(f"Original array: {test_array}")
    print(f"Sorted array: {sorted_array}")
