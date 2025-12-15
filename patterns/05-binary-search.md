# Pattern 5: Binary Search

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

Binary Search is a fundamental searching algorithm that efficiently finds a target value in a sorted array by repeatedly dividing the search space in half. This pattern is essential for:

- Searching in sorted arrays
- Finding boundaries (first/last occurrence)
- Search space reduction problems
- Peak finding
- Rotated array searches

**Key Advantage**: Reduces time complexity from O(n) to O(log n) by eliminating half of the search space in each iteration.

## Pattern Variations

### 1. **Classic Binary Search**
- Find exact target in sorted array
- **Time**: O(log n), **Space**: O(1)
- **Best for**: Finding specific elements

### 2. **Finding Boundaries**
- Find first/last occurrence of target
- **Time**: O(log n), **Space**: O(1)
- **Best for**: Range queries, duplicate handling

### 3. **Rotated Array Search**
- Search in rotated sorted array
- **Time**: O(log n), **Space**: O(1)
- **Best for**: Rotated/shifted arrays

### 4. **Binary Search on Answer**
- Search for optimal value in solution space
- **Time**: O(log(max-min) * f(n))
- **Best for**: Optimization problems

---

## Core Concepts

### When to Use Binary Search?

✓ **Use when:**
- Array is sorted (or can be sorted)
- Need to find specific value or boundary
- Search space can be divided monotonically
- Need O(log n) time complexity
- Working with infinite/large search spaces

✗ **Don't use when:**
- Array is unsorted and can't be sorted
- Need to find all occurrences in O(n)
- Problem requires examining all elements

### Key Principles

1. **Invariant Maintenance**: Always maintain that target (if exists) is within [left, right]
2. **Mid Calculation**: Use `mid = left + (right - left) // 2` to avoid overflow
3. **Search Space Reduction**: Eliminate half the search space each iteration
4. **Boundary Handling**: Careful with `<` vs `<=`, `mid+1` vs `mid`

---

## Detailed Implementations

### Pattern 1: Classic Binary Search

```python
def binary_search(arr, target):
    """
    Classic binary search for exact match.
    
    Args:
        arr: Sorted array
        target: Value to find
    
    Returns:
        Index of target, or -1 if not found
    
    Time: O(log n), Space: O(1)
    """
    left = 0
    right = len(arr) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1  # Search right half
        else:
            right = mid - 1  # Search left half
    
    return -1

# Test cases
print(binary_search([1, 2, 3, 4, 5, 6], 4))      # 3
print(binary_search([1, 2, 3, 4, 5, 6], 7))      # -1
print(binary_search([1], 1))                      # 0
print(binary_search([], 1))                       # -1
```

### Pattern 2: Find First Occurrence (Left Boundary)

```python
def find_first_occurrence(arr, target):
    """
    Find the first (leftmost) occurrence of target.
    
    Args:
        arr: Sorted array (may have duplicates)
        target: Value to find
    
    Returns:
        Index of first occurrence, or -1
    
    Time: O(log n), Space: O(1)
    """
    left = 0
    right = len(arr) - 1
    result = -1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if arr[mid] == target:
            result = mid
            right = mid - 1  # Continue searching left
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return result

# Test cases
print(find_first_occurrence([1, 2, 2, 2, 3, 4], 2))  # 1
print(find_first_occurrence([1, 2, 3, 4, 5], 3))     # 2
print(find_first_occurrence([1, 1, 1, 1], 1))        # 0
```

### Pattern 3: Find Last Occurrence (Right Boundary)

```python
def find_last_occurrence(arr, target):
    """
    Find the last (rightmost) occurrence of target.
    
    Args:
        arr: Sorted array (may have duplicates)
        target: Value to find
    
    Returns:
        Index of last occurrence, or -1
    
    Time: O(log n), Space: O(1)
    """
    left = 0
    right = len(arr) - 1
    result = -1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if arr[mid] == target:
            result = mid
            left = mid + 1  # Continue searching right
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return result

# Test cases
print(find_last_occurrence([1, 2, 2, 2, 3, 4], 2))   # 3
print(find_last_occurrence([1, 2, 3, 4, 5], 3))      # 2
print(find_last_occurrence([1, 1, 1, 1], 1))         # 3
```

### Pattern 4: Search in Rotated Sorted Array

```python
def search_rotated(arr, target):
    """
    Search in rotated sorted array (no duplicates).
    
    Args:
        arr: Rotated sorted array
        target: Value to find
    
    Returns:
        Index of target, or -1
    
    Time: O(log n), Space: O(1)
    
    Example: [4,5,6,7,0,1,2] rotated at index 4
    """
    left = 0
    right = len(arr) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if arr[mid] == target:
            return mid
        
        # Determine which half is sorted
        if arr[left] <= arr[mid]:
            # Left half is sorted
            if arr[left] <= target < arr[mid]:
                right = mid - 1
            else:
                left = mid + 1
        else:
            # Right half is sorted
            if arr[mid] < target <= arr[right]:
                left = mid + 1
            else:
                right = mid - 1
    
    return -1

# Test cases
print(search_rotated([4, 5, 6, 7, 0, 1, 2], 0))  # 4
print(search_rotated([4, 5, 6, 7, 0, 1, 2], 3))  # -1
print(search_rotated([1], 0))                     # -1
```

### Pattern 5: Find Minimum in Rotated Sorted Array

```python
def find_min_rotated(arr):
    """
    Find minimum element in rotated sorted array.
    
    Args:
        arr: Rotated sorted array
    
    Returns:
        Minimum element value
    
    Time: O(log n), Space: O(1)
    """
    left = 0
    right = len(arr) - 1
    
    while left < right:
        mid = left + (right - left) // 2
        
        if arr[mid] > arr[right]:
            # Minimum is in right half
            left = mid + 1
        else:
            # Minimum is in left half or mid
            right = mid
    
    return arr[left]

# Test cases
print(find_min_rotated([3, 4, 5, 1, 2]))  # 1
print(find_min_rotated([4, 5, 6, 7, 0, 1, 2]))  # 0
print(find_min_rotated([11, 13, 15, 17]))  # 11
```

---

## Complexity Analysis

### Time Complexity

| Pattern | Time | Space | Notes |
|---------|------|-------|-------|
| Classic Search | O(log n) | O(1) | Halves search space each iteration |
| Find Boundaries | O(log n) | O(1) | May need to continue after finding target |
| Rotated Array | O(log n) | O(1) | Identifies sorted half first |
| Binary Search on Answer | O(log(max-min) * f(n)) | O(1) | f(n) is validation function cost |

### Space Complexity

**O(1) Space**: Iterative implementation uses only a few variables.

**Recursive Implementation**: O(log n) space due to call stack depth.

---

## Example Problems

### Problem 1: Binary Search (LeetCode 704)

```python
def search(nums, target):
    """
    LeetCode 704: Binary Search
    
    Args:
        nums: Sorted array in ascending order
        target: Target value
    
    Returns:
        Index of target, or -1 if not found
    
    Example:
        Input: nums = [-1,0,3,5,9,12], target = 9
        Output: 4
    """
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return mid
        elif nums[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return -1

# Test cases
print(search([-1, 0, 3, 5, 9, 12], 9))   # 4
print(search([-1, 0, 3, 5, 9, 12], 2))   # -1
```

### Problem 2: First Bad Version (LeetCode 278)

```python
def isBadVersion(version):
    """Mock API - normally provided by problem"""
    bad_version = 4
    return version >= bad_version

def firstBadVersion(n):
    """
    LeetCode 278: First Bad Version
    
    You are a product manager and have n versions [1, 2, ..., n].
    Find the first bad version using minimum API calls.
    
    Args:
        n: Number of versions
    
    Returns:
        First bad version number
    
    Example:
        Input: n = 5, bad = 4
        Output: 4
        Calls: isBadVersion(3) -> false
               isBadVersion(5) -> true
               isBadVersion(4) -> true
    """
    left, right = 1, n
    
    while left < right:
        mid = left + (right - left) // 2
        
        if isBadVersion(mid):
            right = mid  # First bad is at mid or before
        else:
            left = mid + 1  # First bad is after mid
    
    return left

# Test case
print(firstBadVersion(5))  # 4 (assuming bad version is 4)
```

### Problem 3: Search Insert Position (LeetCode 35)

```python
def searchInsert(nums, target):
    """
    LeetCode 35: Search Insert Position
    
    Find index where target would be inserted in sorted array.
    
    Args:
        nums: Sorted array
        target: Target value
    
    Returns:
        Index where target should be inserted
    
    Example:
        Input: nums = [1,3,5,6], target = 5
        Output: 2
        
        Input: nums = [1,3,5,6], target = 2
        Output: 1
    """
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return mid
        elif nums[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return left  # Insert position

# Test cases
print(searchInsert([1, 3, 5, 6], 5))  # 2
print(searchInsert([1, 3, 5, 6], 2))  # 1
print(searchInsert([1, 3, 5, 6], 7))  # 4
print(searchInsert([1, 3, 5, 6], 0))  # 0
```

### Problem 4: Find Peak Element (LeetCode 162)

```python
def findPeakElement(nums):
    """
    LeetCode 162: Find Peak Element
    
    A peak element is greater than its neighbors.
    Find any peak element.
    
    Args:
        nums: Array of integers
    
    Returns:
        Index of a peak element
    
    Example:
        Input: nums = [1,2,3,1]
        Output: 2 (nums[2] = 3 is peak)
    """
    left, right = 0, len(nums) - 1
    
    while left < right:
        mid = left + (right - left) // 2
        
        if nums[mid] > nums[mid + 1]:
            # Peak is on left side or at mid
            right = mid
        else:
            # Peak is on right side
            left = mid + 1
    
    return left

# Test cases
print(findPeakElement([1, 2, 3, 1]))      # 2
print(findPeakElement([1, 2, 1, 3, 5, 6, 4]))  # 5 or 1
```

### Problem 5: Find First and Last Position (LeetCode 34)

```python
def searchRange(nums, target):
    """
    LeetCode 34: Find First and Last Position of Element in Sorted Array
    
    Args:
        nums: Sorted array
        target: Target value
    
    Returns:
        [first_position, last_position], or [-1, -1]
    
    Example:
        Input: nums = [5,7,7,8,8,10], target = 8
        Output: [3, 4]
    """
    def find_boundary(is_first):
        left, right = 0, len(nums) - 1
        result = -1
        
        while left <= right:
            mid = left + (right - left) // 2
            
            if nums[mid] == target:
                result = mid
                if is_first:
                    right = mid - 1  # Search left for first
                else:
                    left = mid + 1   # Search right for last
            elif nums[mid] < target:
                left = mid + 1
            else:
                right = mid - 1
        
        return result
    
    first = find_boundary(True)
    last = find_boundary(False)
    
    return [first, last]

# Test cases
print(searchRange([5, 7, 7, 8, 8, 10], 8))  # [3, 4]
print(searchRange([5, 7, 7, 8, 8, 10], 6))  # [-1, -1]
print(searchRange([], 0))                    # [-1, -1]
```

### Problem 6: Search in Rotated Sorted Array (LeetCode 33)

```python
def search_rotated_array(nums, target):
    """
    LeetCode 33: Search in Rotated Sorted Array
    
    Args:
        nums: Rotated sorted array (no duplicates)
        target: Target value
    
    Returns:
        Index of target, or -1
    
    Example:
        Input: nums = [4,5,6,7,0,1,2], target = 0
        Output: 4
    """
    left, right = 0, len(nums) - 1
    
    while left <= right:
        mid = left + (right - left) // 2
        
        if nums[mid] == target:
            return mid
        
        # Check which half is sorted
        if nums[left] <= nums[mid]:
            # Left half is sorted
            if nums[left] <= target < nums[mid]:
                right = mid - 1
            else:
                left = mid + 1
        else:
            # Right half is sorted
            if nums[mid] < target <= nums[right]:
                left = mid + 1
            else:
                right = mid - 1
    
    return -1

# Test cases
print(search_rotated_array([4, 5, 6, 7, 0, 1, 2], 0))  # 4
print(search_rotated_array([4, 5, 6, 7, 0, 1, 2], 3))  # -1
print(search_rotated_array([1], 0))                     # -1
```

### Problem 7: Sqrt(x) (LeetCode 69)

```python
def mySqrt(x):
    """
    LeetCode 69: Sqrt(x)
    
    Compute and return the square root of x (rounded down).
    
    Args:
        x: Non-negative integer
    
    Returns:
        Square root of x (integer part)
    
    Example:
        Input: x = 8
        Output: 2 (sqrt(8) = 2.828...)
    """
    if x < 2:
        return x
    
    left, right = 1, x // 2
    
    while left <= right:
        mid = left + (right - left) // 2
        square = mid * mid
        
        if square == x:
            return mid
        elif square < x:
            left = mid + 1
        else:
            right = mid - 1
    
    return right  # Right is the floor of sqrt

# Test cases
print(mySqrt(4))   # 2
print(mySqrt(8))   # 2
print(mySqrt(16))  # 4
print(mySqrt(1))   # 1
```

### Problem 8: Capacity To Ship Packages Within D Days (LeetCode 1011)

```python
def shipWithinDays(weights, days):
    """
    LeetCode 1011: Capacity To Ship Packages Within D Days
    
    Binary search on answer: find minimum ship capacity.
    
    Args:
        weights: Array of package weights
        days: Number of days to ship all packages
    
    Returns:
        Minimum ship capacity
    
    Example:
        Input: weights = [1,2,3,4,5,6,7,8,9,10], days = 5
        Output: 15
    """
    def can_ship(capacity):
        """Check if we can ship all packages with given capacity."""
        days_needed = 1
        current_load = 0
        
        for weight in weights:
            if current_load + weight > capacity:
                days_needed += 1
                current_load = weight
            else:
                current_load += weight
        
        return days_needed <= days
    
    # Binary search on capacity
    left = max(weights)  # Must be at least max weight
    right = sum(weights)  # At most sum of all weights
    
    while left < right:
        mid = left + (right - left) // 2
        
        if can_ship(mid):
            right = mid  # Try smaller capacity
        else:
            left = mid + 1  # Need larger capacity
    
    return left

# Test cases
print(shipWithinDays([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5))  # 15
print(shipWithinDays([3, 2, 2, 4, 1, 4], 3))  # 6
print(shipWithinDays([1, 2, 3, 1, 1], 4))  # 3
```

---

## Use Cases and Best Practices

### Best Use Cases

1. **Searching Problems**
   - Find element in sorted array
   - Find boundaries/ranges
   - Find insertion position

2. **Optimization Problems**
   - Minimize/maximize with validation function
   - Capacity/allocation problems
   - Threshold finding

3. **Array Manipulation**
   - Rotated arrays
   - Peak finding
   - Matrix search (row/col sorted)

4. **Math Problems**
   - Integer square root
   - Power computation
   - Division without operator

### Best Practices

✓ **Do's**
- Use `mid = left + (right - left) // 2` to prevent overflow
- Be clear about loop condition: `left < right` vs `left <= right`
- Understand when to use `mid + 1` vs `mid` for boundary updates
- Test with edge cases: empty array, single element, duplicates
- Draw diagrams to understand search space reduction

✗ **Don'ts**
- Don't use binary search on unsorted data without sorting first
- Don't forget to handle empty arrays
- Don't use floating point for mid calculation
- Don't modify array during binary search
- Don't use binary search when linear scan is simpler

### Decision Framework

```
Can the problem benefit from binary search?
├─ Is data sorted? (or can be sorted?)
│  ├─ YES → Classic binary search
│  └─ NO  → Can we define a monotonic decision function?
│           ├─ YES → Binary search on answer
│           └─ NO  → Use different approach
├─ Need boundaries?
│  └─ YES → Find first/last occurrence pattern
└─ Special structure (rotated, matrix)?
   └─ YES → Modified binary search
```

---

## Common Pitfalls

### Pitfall 1: Integer Overflow

```python
# ❌ WRONG: Can overflow in languages like Java/C++
mid = (left + right) // 2

# ✓ CORRECT: Prevents overflow
mid = left + (right - left) // 2
```

### Pitfall 2: Wrong Loop Condition

```python
def wrong_binary_search(arr, target):
    # ❌ WRONG: May miss single element or cause infinite loop
    left, right = 0, len(arr) - 1
    while left < right:
        mid = left + (right - left) // 2
        if arr[mid] == target:
            return mid
        # If we update left = mid, infinite loop when left+1 == right

def correct_binary_search(arr, target):
    # ✓ CORRECT: Use <= for exact match, < for boundary finding
    left, right = 0, len(arr) - 1
    while left <= right:  # For exact match
        mid = left + (right - left) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1
```

### Pitfall 3: Incorrect Boundary Updates

```python
# ❌ WRONG: May skip the answer
while left < right:
    mid = left + (right - left) // 2
    if condition(mid):
        left = mid  # Can cause infinite loop!
    else:
        right = mid - 1

# ✓ CORRECT: Always make progress
while left < right:
    mid = left + (right - left) // 2
    if condition(mid):
        left = mid + 1  # Or use ceiling division for mid
    else:
        right = mid
```

### Pitfall 4: Off-by-One Errors

```python
# ❌ WRONG: Returns wrong boundary
def find_first_occurrence(arr, target):
    # ... binary search logic
    return mid  # May not be the first occurrence!

# ✓ CORRECT: Continue searching after finding target
def find_first_occurrence(arr, target):
    result = -1
    while left <= right:
        mid = left + (right - left) // 2
        if arr[mid] == target:
            result = mid
            right = mid - 1  # Keep searching left
        # ...
    return result
```

### Pitfall 5: Not Handling Edge Cases

```python
# ❌ WRONG: Crashes on empty array
def binary_search(arr, target):
    mid = len(arr) // 2
    # No check for empty array!

# ✓ CORRECT: Handle edge cases
def binary_search(arr, target):
    if not arr:
        return -1
    
    left, right = 0, len(arr) - 1
    # Rest of logic...
```

---

## Interview Tips

### How to Approach in Interview

1. **Clarify Requirements**
   - Is array sorted?
   - Are there duplicates?
   - What to return if not found?
   - Any specific boundary behavior?

2. **Choose Right Variant**
   - Exact match vs boundary search
   - Standard vs modified (rotated, matrix)
   - Iterative vs recursive

3. **Explain Your Approach**
   - "I'll use binary search because the array is sorted..."
   - "The search space is [left, right]..."
   - "I'm choosing left <= right because..."

4. **Walk Through Example**
   - Show how search space reduces
   - Demonstrate boundary updates
   - Handle edge cases

5. **State Complexity**
   - "Time: O(log n) - halving search space each iteration"
   - "Space: O(1) - using only a few variables"

### What Interviewers Look For

✓ Understanding of why binary search works
✓ Correct loop conditions and boundary updates
✓ Handling of edge cases
✓ Clear variable naming
✓ Ability to explain trade-offs
✓ Recognition of when to use binary search

### Follow-up Questions to Prepare For

- "What if array has duplicates?"
- "Can you find all occurrences?"
- "What's the space complexity of recursive version?"
- "How would you handle rotated array?"
- "Can you apply this to 2D array?"
- "What if we don't know array length?" (infinite array)

---

## Summary

| Aspect | Details |
|--------|---------|
| **When to use** | Sorted data, monotonic decision functions |
| **Main advantage** | O(log n) time complexity |
| **Main variations** | Exact search, boundaries, rotated, answer search |
| **Time complexity** | O(log n) |
| **Space complexity** | O(1) iterative, O(log n) recursive |
| **Difficulty** | Medium (understanding boundaries) |

---

## References and Resources

- LeetCode Tag: Binary Search
- GeeksforGeeks: Binary Search Tutorial
- Binary Search Boundary Templates
- "Programming Pearls" by Jon Bentley

**Related Patterns:**
- Two Pointers (similar search space reduction)
- Divide and Conquer (divide strategy)
- Dynamic Programming (some problems can use both)
