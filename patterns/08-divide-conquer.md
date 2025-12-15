# Pattern 8: Divide & Conquer

## Table of Contents
1. [Overview](#overview)
2. [Pattern Variations](#pattern-variations)
3. [Core Concepts](#core-concepts)
4. [Detailed Implementations](#detailed-implementations)
5. [Complexity Analysis](#complexity-analysis)
6. [Example Problems](#example-problems)
7. [Use Cases and Best Practices](#use-cases-and-best-practices)
8. [Common Pitfalls](#common-pitfalls)

## Overview

Divide and Conquer is a problem-solving paradigm that breaks problems into smaller subproblems, solves them recursively, and combines solutions. This pattern is essential for:

- Sorting algorithms (Merge Sort, Quick Sort)
- Searching algorithms (Binary Search)
- Array problems (count inversions, max subarray)
- Mathematical computations (power, multiply)
- Tree/graph algorithms

**Key Advantage**: Reduces time complexity from O(n²) to O(n log n) for many problems.

## Pattern Variations

### 1. **Classic Divide & Conquer**
- Equal division (Merge Sort)
- **Time**: O(n log n), **Space**: O(n) or O(log n)

### 2. **Unequal Division**
- Pivot-based division (Quick Sort)
- **Time**: O(n log n) average

### 3. **Master Theorem Applications**
- Analyzing recursive algorithms
- **Time**: Based on recurrence relation

---

## Core Concepts

### Three Steps

1. **Divide**: Break problem into smaller subproblems
2. **Conquer**: Solve subproblems recursively
3. **Combine**: Merge solutions to get final answer

### Master Theorem

For recurrence: T(n) = aT(n/b) + f(n)

- If f(n) = O(n^(log_b(a) - ε)): T(n) = Θ(n^log_b(a))
- If f(n) = Θ(n^log_b(a)): T(n) = Θ(n^log_b(a) * log n)
- If f(n) = Ω(n^(log_b(a) + ε)): T(n) = Θ(f(n))

---

## Detailed Implementations

### Pattern 1: Merge Sort

```python
def merge_sort(arr):
    """
    Sort array using merge sort.
    
    Time: O(n log n), Space: O(n)
    """
    if len(arr) <= 1:
        return arr
    
    # Divide
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    
    # Conquer & Combine
    return merge(left, right)

def merge(left, right):
    """Merge two sorted arrays."""
    result = []
    i = j = 0
    
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    
    result.extend(left[i:])
    result.extend(right[j:])
    return result

# Test
print(merge_sort([38, 27, 43, 3, 9, 82, 10]))  # [3, 9, 10, 27, 38, 43, 82]
```

### Pattern 2: Quick Sort

```python
def quick_sort(arr):
    """
    Sort array using quick sort.
    
    Time: O(n log n) average, O(n²) worst
    Space: O(log n) recursion stack
    """
    if len(arr) <= 1:
        return arr
    
    # Divide: choose pivot
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    # Conquer & Combine
    return quick_sort(left) + middle + quick_sort(right)

# Test
print(quick_sort([3, 6, 8, 10, 1, 2, 1]))  # [1, 1, 2, 3, 6, 8, 10]
```

### Pattern 3: Count Inversions

```python
def count_inversions(arr):
    """
    Count number of inversions (pairs where i < j but arr[i] > arr[j]).
    
    Time: O(n log n), Space: O(n)
    """
    def merge_count(left, right):
        result = []
        inversions = 0
        i = j = 0
        
        while i < len(left) and j < len(right):
            if left[i] <= right[j]:
                result.append(left[i])
                i += 1
            else:
                result.append(right[j])
                inversions += len(left) - i  # All remaining in left are inversions
                j += 1
        
        result.extend(left[i:])
        result.extend(right[j:])
        return result, inversions
    
    def sort_count(arr):
        if len(arr) <= 1:
            return arr, 0
        
        mid = len(arr) // 2
        left, left_inv = sort_count(arr[:mid])
        right, right_inv = sort_count(arr[mid:])
        merged, merge_inv = merge_count(left, right)
        
        return merged, left_inv + right_inv + merge_inv
    
    _, count = sort_count(arr)
    return count

# Test
print(count_inversions([2, 3, 8, 6, 1]))  # 5 inversions
```

### Pattern 4: Maximum Subarray (Divide & Conquer)

```python
def max_subarray(arr):
    """
    Find maximum sum subarray using divide and conquer.
    
    Time: O(n log n), Space: O(log n)
    """
    def max_crossing_sum(arr, left, mid, right):
        # Left side
        left_sum = float('-inf')
        current_sum = 0
        for i in range(mid, left - 1, -1):
            current_sum += arr[i]
            left_sum = max(left_sum, current_sum)
        
        # Right side
        right_sum = float('-inf')
        current_sum = 0
        for i in range(mid + 1, right + 1):
            current_sum += arr[i]
            right_sum = max(right_sum, current_sum)
        
        return left_sum + right_sum
    
    def max_subarray_helper(arr, left, right):
        if left == right:
            return arr[left]
        
        mid = (left + right) // 2
        
        left_max = max_subarray_helper(arr, left, mid)
        right_max = max_subarray_helper(arr, mid + 1, right)
        cross_max = max_crossing_sum(arr, left, mid, right)
        
        return max(left_max, right_max, cross_max)
    
    return max_subarray_helper(arr, 0, len(arr) - 1)

# Test
print(max_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4]))  # 6
```

### Pattern 5: Power Function

```python
def power(x, n):
    """
    Calculate x^n efficiently using divide and conquer.
    
    Time: O(log n), Space: O(log n)
    """
    if n == 0:
        return 1
    if n < 0:
        return 1 / power(x, -n)
    
    # Divide
    half = power(x, n // 2)
    
    # Combine
    if n % 2 == 0:
        return half * half
    else:
        return half * half * x

# Test
print(power(2, 10))   # 1024
print(power(2, -2))   # 0.25
```

---

## Example Problems

### Problem 1: Merge K Sorted Lists (LeetCode 23)

```python
import heapq

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def mergeKLists(lists):
    """
    Merge k sorted linked lists using divide and conquer.
    
    Time: O(N log k), Space: O(log k)
    N = total nodes, k = number of lists
    """
    if not lists:
        return None
    
    def merge_two(l1, l2):
        dummy = ListNode(0)
        current = dummy
        
        while l1 and l2:
            if l1.val < l2.val:
                current.next = l1
                l1 = l1.next
            else:
                current.next = l2
                l2 = l2.next
            current = current.next
        
        current.next = l1 or l2
        return dummy.next
    
    def merge_lists(lists, left, right):
        if left == right:
            return lists[left]
        
        mid = (left + right) // 2
        l1 = merge_lists(lists, left, mid)
        l2 = merge_lists(lists, mid + 1, right)
        
        return merge_two(l1, l2)
    
    return merge_lists(lists, 0, len(lists) - 1)
```

### Problem 2: Majority Element (LeetCode 169)

```python
def majorityElement(nums):
    """
    Find majority element using divide and conquer.
    
    Time: O(n log n), Space: O(log n)
    """
    def majority_in_range(left, right):
        if left == right:
            return nums[left]
        
        mid = (left + right) // 2
        left_maj = majority_in_range(left, mid)
        right_maj = majority_in_range(mid + 1, right)
        
        if left_maj == right_maj:
            return left_maj
        
        # Count occurrences
        left_count = sum(1 for i in range(left, right + 1) if nums[i] == left_maj)
        right_count = sum(1 for i in range(left, right + 1) if nums[i] == right_maj)
        
        return left_maj if left_count > right_count else right_maj
    
    return majority_in_range(0, len(nums) - 1)

# Test
print(majorityElement([3, 2, 3]))  # 3
print(majorityElement([2, 2, 1, 1, 1, 2, 2]))  # 2
```

---

## Common Pitfalls

### Pitfall 1: Not Handling Base Case

```python
# ❌ WRONG
def divide_conquer(arr):
    mid = len(arr) // 2
    return divide_conquer(arr[:mid]) + divide_conquer(arr[mid:])  # Infinite recursion!

# ✓ CORRECT
def divide_conquer(arr):
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    return divide_conquer(arr[:mid]) + divide_conquer(arr[mid:])
```

## Interview Tips

- Identify divide step clearly
- Analyze with Master Theorem
- Consider space complexity of recursion
- Compare with iterative approaches

---

## Summary

| Aspect | Details |
|--------|---------|
| **When to use** | Sorting, searching, array processing |
| **Complexity** | Often O(n log n) |
| **Space** | O(n) or O(log n) recursion |
| **Difficulty** | Medium |
