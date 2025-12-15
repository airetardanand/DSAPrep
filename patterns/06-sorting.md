# Pattern 6: Sorting-Based Patterns

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

Sorting-based patterns involve using sorting as a preprocessing step to simplify problem-solving. Many complex problems become trivial after sorting the input data. This pattern includes:

- Sort then process
- Custom comparators
- Counting/bucket sort
- Meeting rooms/intervals
- Sorting with constraints

**Key Advantage**: Converts O(n²) or harder problems into O(n log n) + O(n) = O(n log n) solutions.

## Pattern Variations

### 1. **Sort Then Process**
- Sort data first, then apply linear algorithm
- **Time**: O(n log n), **Space**: O(1) to O(n)
- **Best for**: Finding pairs, intervals, grouping

### 2. **Custom Comparators**
- Sort with custom comparison logic
- **Time**: O(n log n), **Space**: O(1)
- **Best for**: Multi-criteria sorting, complex objects

### 3. **Counting/Bucket Sort**
- Sort using frequency/buckets when range is limited
- **Time**: O(n + k), **Space**: O(k)
- **Best for**: Small range integers, frequency-based

### 4. **Partial Sorting**
- Sort only what's needed (QuickSelect, heaps)
- **Time**: O(n) average, **Space**: O(1)
- **Best for**: Kth element, top-k problems

---

## Core Concepts

### When to Use Sorting?

✓ **Use when:**
- Problem involves finding pairs/groups with relationships
- Need to process elements in order
- Comparing intervals or ranges
- Finding duplicates or unique elements efficiently
- Order doesn't matter in output

✗ **Don't use when:**
- Original order must be preserved (unless using stable sort)
- Sorting cost dominates (O(n log n) > better algorithm)
- Problem can be solved in O(n) without sorting

### Sorting Algorithm Selection

| Algorithm | Time | Space | Stable | Use Case |
|-----------|------|-------|--------|----------|
| Quick Sort | O(n log n) avg | O(log n) | No | General purpose, in-place |
| Merge Sort | O(n log n) | O(n) | Yes | Stable, linked lists |
| Heap Sort | O(n log n) | O(1) | No | In-place, worst-case guarantee |
| Counting Sort | O(n + k) | O(k) | Yes | Small integer range |
| Bucket Sort | O(n + k) | O(n + k) | Yes | Uniform distribution |

---

## Detailed Implementations

### Pattern 1: Sort Then Process (Basic)

```python
def two_sum_sorted(nums, target):
    """
    Find two numbers that sum to target by sorting first.
    
    Args:
        nums: Array of integers
        target: Target sum
    
    Returns:
        Pair of numbers that sum to target
    
    Time: O(n log n), Space: O(n)
    """
    # Create list of (value, original_index) pairs
    indexed_nums = [(num, i) for i, num in enumerate(nums)]
    indexed_nums.sort()  # Sort by value
    
    left, right = 0, len(indexed_nums) - 1
    
    while left < right:
        current_sum = indexed_nums[left][0] + indexed_nums[right][0]
        
        if current_sum == target:
            return [indexed_nums[left][1], indexed_nums[right][1]]
        elif current_sum < target:
            left += 1
        else:
            right -= 1
    
    return []

# Test cases
print(two_sum_sorted([2, 7, 11, 15], 9))  # [0, 1]
print(two_sum_sorted([3, 2, 4], 6))       # [1, 2]
```

### Pattern 2: Custom Comparator

```python
from functools import cmp_to_key

def largest_number_custom_sort(nums):
    """
    Arrange numbers to form the largest number using custom comparator.
    
    Args:
        nums: Array of non-negative integers
    
    Returns:
        Largest number as string
    
    Time: O(n log n), Space: O(n)
    
    Example: [3, 30, 34, 5, 9] -> "9534330"
    """
    def compare(x, y):
        # Compare which concatenation is larger
        if x + y > y + x:
            return -1  # x should come before y
        elif x + y < y + x:
            return 1   # y should come before x
        else:
            return 0   # equal
    
    # Convert to strings for concatenation
    nums_str = [str(num) for num in nums]
    
    # Sort with custom comparator
    nums_str.sort(key=cmp_to_key(compare))
    
    # Handle edge case: all zeros
    result = ''.join(nums_str)
    return '0' if result[0] == '0' else result

# Test cases
print(largest_number_custom_sort([10, 2]))        # "210"
print(largest_number_custom_sort([3, 30, 34, 5, 9]))  # "9534330"
print(largest_number_custom_sort([0, 0]))         # "0"
```

### Pattern 3: Counting Sort

```python
def counting_sort(arr, max_val):
    """
    Sort array using counting sort (for small range integers).
    
    Args:
        arr: Array of non-negative integers
        max_val: Maximum value in array
    
    Returns:
        Sorted array
    
    Time: O(n + k), Space: O(k) where k is range
    """
    # Count occurrences
    count = [0] * (max_val + 1)
    for num in arr:
        count[num] += 1
    
    # Build sorted array
    result = []
    for num in range(max_val + 1):
        result.extend([num] * count[num])
    
    return result

# Test cases
print(counting_sort([4, 2, 2, 8, 3, 3, 1], 8))  # [1, 2, 2, 3, 3, 4, 8]
print(counting_sort([1, 0, 3, 1, 3, 1], 3))     # [0, 1, 1, 1, 3, 3]
```

### Pattern 4: Bucket Sort for Floats

```python
def bucket_sort(arr):
    """
    Sort array of floats in [0, 1) using bucket sort.
    
    Args:
        arr: Array of floats in range [0, 1)
    
    Returns:
        Sorted array
    
    Time: O(n) average, Space: O(n)
    """
    n = len(arr)
    if n == 0:
        return []
    
    # Create n buckets
    buckets = [[] for _ in range(n)]
    
    # Distribute elements into buckets
    for num in arr:
        bucket_index = int(num * n)
        if bucket_index == n:  # Handle edge case for 1.0
            bucket_index = n - 1
        buckets[bucket_index].append(num)
    
    # Sort individual buckets and concatenate
    result = []
    for bucket in buckets:
        bucket.sort()  # Use insertion sort for small buckets
        result.extend(bucket)
    
    return result

# Test cases
print(bucket_sort([0.78, 0.17, 0.39, 0.26, 0.72, 0.94, 0.21, 0.12, 0.23, 0.68]))
# [0.12, 0.17, 0.21, 0.23, 0.26, 0.39, 0.68, 0.72, 0.78, 0.94]
```

### Pattern 5: QuickSelect for Kth Element

```python
import random

def find_kth_largest(nums, k):
    """
    Find kth largest element using QuickSelect (partial sorting).
    
    Args:
        nums: Array of integers
        k: Find kth largest (1-indexed)
    
    Returns:
        Kth largest element
    
    Time: O(n) average, O(n²) worst, Space: O(1)
    """
    def partition(left, right, pivot_idx):
        pivot = nums[pivot_idx]
        # Move pivot to end
        nums[pivot_idx], nums[right] = nums[right], nums[pivot_idx]
        
        store_idx = left
        for i in range(left, right):
            if nums[i] < pivot:
                nums[i], nums[store_idx] = nums[store_idx], nums[i]
                store_idx += 1
        
        # Move pivot to final position
        nums[store_idx], nums[right] = nums[right], nums[store_idx]
        return store_idx
    
    def quickselect(left, right, k_smallest):
        if left == right:
            return nums[left]
        
        # Random pivot for average O(n)
        pivot_idx = random.randint(left, right)
        pivot_idx = partition(left, right, pivot_idx)
        
        if k_smallest == pivot_idx:
            return nums[k_smallest]
        elif k_smallest < pivot_idx:
            return quickselect(left, pivot_idx - 1, k_smallest)
        else:
            return quickselect(pivot_idx + 1, right, k_smallest)
    
    # Convert kth largest to kth smallest index
    return quickselect(0, len(nums) - 1, len(nums) - k)

# Test cases
print(find_kth_largest([3, 2, 1, 5, 6, 4], 2))  # 5
print(find_kth_largest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))  # 4
```

---

## Complexity Analysis

### Time Complexity

| Pattern | Best | Average | Worst | Space |
|---------|------|---------|-------|-------|
| Sort + Process | O(n log n) | O(n log n) | O(n log n) | O(1)-O(n) |
| Custom Comparator | O(n log n) | O(n log n) | O(n log n) | O(log n) |
| Counting Sort | O(n + k) | O(n + k) | O(n + k) | O(k) |
| Bucket Sort | O(n) | O(n + k) | O(n²) | O(n + k) |
| QuickSelect | O(n) | O(n) | O(n²) | O(1) |

### When to Use Which

- **n log n sorts**: General purpose, unknown data distribution
- **Counting sort**: Small integer range (k ≈ n)
- **Bucket sort**: Uniform float distribution
- **QuickSelect**: Only need kth element, not full sort

---

## Example Problems

### Problem 1: Merge Intervals (LeetCode 56)

```python
def merge_intervals(intervals):
    """
    LeetCode 56: Merge Intervals
    
    Merge overlapping intervals.
    
    Args:
        intervals: List of [start, end] intervals
    
    Returns:
        List of merged intervals
    
    Example:
        Input: [[1,3],[2,6],[8,10],[15,18]]
        Output: [[1,6],[8,10],[15,18]]
    """
    if not intervals:
        return []
    
    # Sort by start time
    intervals.sort(key=lambda x: x[0])
    
    merged = [intervals[0]]
    
    for current in intervals[1:]:
        last = merged[-1]
        
        if current[0] <= last[1]:
            # Overlapping, merge
            last[1] = max(last[1], current[1])
        else:
            # Non-overlapping, add new interval
            merged.append(current)
    
    return merged

# Test cases
print(merge_intervals([[1, 3], [2, 6], [8, 10], [15, 18]]))  # [[1, 6], [8, 10], [15, 18]]
print(merge_intervals([[1, 4], [4, 5]]))  # [[1, 5]]
print(merge_intervals([[1, 4], [0, 4]]))  # [[0, 4]]
```

### Problem 2: Meeting Rooms II (LeetCode 253)

```python
def min_meeting_rooms(intervals):
    """
    LeetCode 253: Meeting Rooms II
    
    Find minimum number of meeting rooms required.
    
    Args:
        intervals: List of [start, end] meeting times
    
    Returns:
        Minimum number of rooms needed
    
    Example:
        Input: [[0,30],[5,10],[15,20]]
        Output: 2
    """
    if not intervals:
        return 0
    
    # Separate and sort start and end times
    starts = sorted([interval[0] for interval in intervals])
    ends = sorted([interval[1] for interval in intervals])
    
    rooms_needed = 0
    max_rooms = 0
    start_ptr = 0
    end_ptr = 0
    
    while start_ptr < len(intervals):
        if starts[start_ptr] < ends[end_ptr]:
            # Meeting starts, need a room
            rooms_needed += 1
            max_rooms = max(max_rooms, rooms_needed)
            start_ptr += 1
        else:
            # Meeting ends, free a room
            rooms_needed -= 1
            end_ptr += 1
    
    return max_rooms

# Test cases
print(min_meeting_rooms([[0, 30], [5, 10], [15, 20]]))  # 2
print(min_meeting_rooms([[7, 10], [2, 4]]))  # 1
```

### Problem 3: Sort Colors (Dutch National Flag) (LeetCode 75)

```python
def sort_colors(nums):
    """
    LeetCode 75: Sort Colors
    
    Sort array with values 0, 1, 2 in-place (Dutch National Flag).
    
    Args:
        nums: Array with 0s, 1s, 2s
    
    Returns:
        None (modify in-place)
    
    Example:
        Input: [2,0,2,1,1,0]
        Output: [0,0,1,1,2,2]
    """
    # Three-way partitioning
    left = 0      # Next position for 0
    right = len(nums) - 1  # Next position for 2
    current = 0   # Current element
    
    while current <= right:
        if nums[current] == 0:
            nums[left], nums[current] = nums[current], nums[left]
            left += 1
            current += 1
        elif nums[current] == 2:
            nums[current], nums[right] = nums[right], nums[current]
            right -= 1
            # Don't increment current (need to check swapped element)
        else:  # nums[current] == 1
            current += 1
    
    return nums

# Test cases
print(sort_colors([2, 0, 2, 1, 1, 0]))  # [0, 0, 1, 1, 2, 2]
print(sort_colors([2, 0, 1]))  # [0, 1, 2]
```

### Problem 4: Largest Number (LeetCode 179)

```python
from functools import cmp_to_key

def largestNumber(nums):
    """
    LeetCode 179: Largest Number
    
    Arrange numbers to form largest number.
    
    Args:
        nums: Array of non-negative integers
    
    Returns:
        Largest number as string
    
    Example:
        Input: [10,2]
        Output: "210"
    """
    # Custom comparator
    def compare(x, y):
        if x + y > y + x:
            return -1
        elif x + y < y + x:
            return 1
        return 0
    
    nums_str = list(map(str, nums))
    nums_str.sort(key=cmp_to_key(compare))
    
    result = ''.join(nums_str)
    
    # Handle all zeros
    return '0' if result[0] == '0' else result

# Test cases
print(largestNumber([10, 2]))  # "210"
print(largestNumber([3, 30, 34, 5, 9]))  # "9534330"
print(largestNumber([0, 0]))  # "0"
```

### Problem 5: Valid Anagram (LeetCode 242)

```python
def isAnagram(s, t):
    """
    LeetCode 242: Valid Anagram
    
    Check if t is anagram of s.
    
    Args:
        s, t: Input strings
    
    Returns:
        True if anagram, False otherwise
    
    Example:
        Input: s = "anagram", t = "nagaram"
        Output: True
    """
    # Method 1: Using sorting
    return sorted(s) == sorted(t)
    
    # Method 2: Using frequency count (more efficient)
    # if len(s) != len(t):
    #     return False
    # 
    # from collections import Counter
    # return Counter(s) == Counter(t)

# Test cases
print(isAnagram("anagram", "nagaram"))  # True
print(isAnagram("rat", "car"))  # False
```

### Problem 6: H-Index (LeetCode 274)

```python
def hIndex(citations):
    """
    LeetCode 274: H-Index
    
    Calculate h-index: max h where researcher has h papers 
    with at least h citations each.
    
    Args:
        citations: Array of citation counts
    
    Returns:
        H-index value
    
    Example:
        Input: [3,0,6,1,5]
        Output: 3 (3 papers with >= 3 citations)
    """
    citations.sort(reverse=True)
    
    h = 0
    for i, citation in enumerate(citations):
        if citation >= i + 1:
            h = i + 1
        else:
            break
    
    return h

# Test cases
print(hIndex([3, 0, 6, 1, 5]))  # 3
print(hIndex([1, 3, 1]))  # 1
print(hIndex([100]))  # 1
```

### Problem 7: Top K Frequent Elements (LeetCode 347)

```python
from collections import Counter
import heapq

def topKFrequent(nums, k):
    """
    LeetCode 347: Top K Frequent Elements
    
    Find k most frequent elements.
    
    Args:
        nums: Array of integers
        k: Number of top elements
    
    Returns:
        List of k most frequent elements
    
    Example:
        Input: nums = [1,1,1,2,2,3], k = 2
        Output: [1, 2]
    """
    # Method 1: Using Counter and sorting
    count = Counter(nums)
    # Sort by frequency (descending)
    return [num for num, freq in count.most_common(k)]
    
    # Method 2: Using heap (more space efficient for small k)
    # count = Counter(nums)
    # return heapq.nlargest(k, count.keys(), key=count.get)

# Test cases
print(topKFrequent([1, 1, 1, 2, 2, 3], 2))  # [1, 2]
print(topKFrequent([1], 1))  # [1]
```

### Problem 8: Relative Sort Array (LeetCode 1122)

```python
def relativeSortArray(arr1, arr2):
    """
    LeetCode 1122: Relative Sort Array
    
    Sort arr1 so elements in arr2 come first in arr2's order,
    then remaining elements in ascending order.
    
    Args:
        arr1: Array to sort
        arr2: Relative order reference
    
    Returns:
        Sorted array
    
    Example:
        Input: arr1 = [2,3,1,3,2,4,6,7,9,2,19], arr2 = [2,1,4,3,9,6]
        Output: [2,2,2,1,4,3,3,9,6,7,19]
    """
    from collections import Counter
    
    count = Counter(arr1)
    result = []
    
    # Add elements in arr2's order
    for num in arr2:
        result.extend([num] * count[num])
        del count[num]
    
    # Add remaining elements in sorted order
    for num in sorted(count.keys()):
        result.extend([num] * count[num])
    
    return result

# Test cases
print(relativeSortArray([2, 3, 1, 3, 2, 4, 6, 7, 9, 2, 19], [2, 1, 4, 3, 9, 6]))
# [2, 2, 2, 1, 4, 3, 3, 9, 6, 7, 19]
```

---

## Use Cases and Best Practices

### Best Use Cases

1. **Interval Problems**
   - Merge intervals
   - Meeting rooms
   - Calendar conflicts

2. **Finding Pairs/Triplets**
   - After sorting, use two pointers
   - 3Sum, 4Sum problems

3. **Top-K Problems**
   - QuickSelect or heap-based partial sorting
   - Frequency-based ranking

4. **Grouping/Anagrams**
   - Sort to create canonical form
   - Group by sorted key

### Best Practices

✓ **Do's**
- Sort as preprocessing when it simplifies problem to O(n)
- Use stable sort when relative order matters
- Consider counting sort for small integer ranges
- Use custom comparators for complex sorting logic
- Cache sort keys if comparison is expensive

✗ **Don'ts**
- Don't sort if problem needs original order
- Don't use O(n log n) sort when O(n) counting sort works
- Don't forget about stability requirements
- Don't modify input unnecessarily
- Don't sort repeatedly in loops

### Decision Framework

```
Problem involves relationships between elements?
├─ Need all elements in order?
│  └─ YES → Full sort O(n log n)
├─ Need only kth element or top-k?
│  └─ YES → Partial sort (QuickSelect, heap)
├─ Small integer range?
│  └─ YES → Counting/bucket sort O(n)
└─ Complex comparison logic?
   └─ YES → Custom comparator
```

---

## Common Pitfalls

### Pitfall 1: Unstable Sort When Order Matters

```python
# ❌ WRONG: May change relative order of equal elements
data = [(1, 'a'), (2, 'b'), (1, 'c')]
data.sort(key=lambda x: x[0])  # Unstable in some languages

# ✓ CORRECT: Use stable sort or sort by multiple keys
data.sort(key=lambda x: (x[0], data.index(x)))  # Maintain original order
```

### Pitfall 2: Modifying While Sorting

```python
# ❌ WRONG: Modifying list during sort can cause issues
def bad_sort(arr):
    arr.sort()
    for i in range(len(arr)):
        arr[i] *= 2  # OK after sort, but not during

# ✓ CORRECT: Sort first, then modify
```

### Pitfall 3: Wrong Comparator Logic

```python
# ❌ WRONG: Comparator doesn't satisfy transitivity
def bad_compare(x, y):
    if random.random() > 0.5:
        return -1
    return 1

# ✓ CORRECT: Comparator must be consistent and transitive
def good_compare(x, y):
    if x < y:
        return -1
    elif x > y:
        return 1
    return 0
```

### Pitfall 4: Ignoring Time Complexity

```python
# ❌ WRONG: Sorting repeatedly in loop
for item in items:
    data.sort()  # O(n log n) per iteration = O(n² log n) total!
    process(data)

# ✓ CORRECT: Sort once before loop
data.sort()
for item in items:
    process(data)
```

### Pitfall 5: Not Handling Edge Cases

```python
# ❌ WRONG: Doesn't handle empty or single element
def merge_intervals(intervals):
    intervals.sort()
    merged = [intervals[0]]  # Crashes if empty!

# ✓ CORRECT: Check edge cases
def merge_intervals(intervals):
    if not intervals:
        return []
    intervals.sort()
    merged = [intervals[0]]
    # ...
```

---

## Interview Tips

### How to Approach

1. **Identify if Sorting Helps**
   - Does order matter?
   - Can sorting simplify relationships?
   - What's the complexity trade-off?

2. **Choose Right Sort**
   - General: default sort (O(n log n))
   - Small range: counting sort
   - Kth element: QuickSelect
   - Custom logic: comparator

3. **Explain Trade-offs**
   - "Sorting takes O(n log n), but then we can..."
   - "After sorting, two pointers gives us O(n)..."
   - "Total: O(n log n) which is better than O(n²)..."

4. **Consider Stability**
   - "We need stable sort because..."
   - "Order of equal elements matters for..."

### What Interviewers Look For

✓ Recognition of when sorting simplifies problem
✓ Knowledge of different sorting algorithms
✓ Ability to write custom comparators
✓ Understanding of time/space complexity
✓ Awareness of stability requirements

### Follow-up Questions

- "What if you can't modify the input?"
- "How would you optimize for mostly sorted data?"
- "What if range is very large?" (bucket sort)
- "Can you do it without sorting?" (hash map alternative)
- "What's the space complexity?"

---

## Summary

| Aspect | Details |
|--------|---------|
| **When to use** | Finding relationships, pairs, intervals, grouping |
| **Main advantage** | Simplifies complex problems to O(n log n) + O(n) |
| **Main variations** | Full sort, partial sort, counting sort, custom |
| **Time complexity** | O(n log n) general, O(n) for counting/bucket |
| **Space complexity** | O(1) to O(n) depending on algorithm |
| **Difficulty** | Easy to Medium |

---

## References and Resources

- LeetCode Tag: Sorting
- "Introduction to Algorithms" (CLRS) - Sorting chapters
- "Programming Pearls" - Column 11 (Sorting)
- Counting Sort and Bucket Sort tutorials

**Related Patterns:**
- Two Pointers (often used after sorting)
- Binary Search (requires sorted data)
- Heap (for partial sorting)
- Hash Map (alternative for grouping)
