# Prefix Sums and Difference Arrays Pattern Guide

## Overview

Prefix Sums and Difference Arrays are powerful optimization techniques used to efficiently calculate range sums, handle range updates, and solve problems involving cumulative values. These patterns reduce time complexity from O(n) per query to O(1) or O(n) preprocessing with O(1) queries.

---

## Table of Contents

1. [Prefix Sums](#prefix-sums)
2. [Difference Arrays](#difference-arrays)
3. [2D Prefix Sums](#2d-prefix-sums)
4. [Common Patterns](#common-patterns)
5. [Problems & Solutions](#problems--solutions)
6. [Interview Tips](#interview-tips)

---

## Prefix Sums

### Concept

A prefix sum array stores the cumulative sum of elements up to each index. For an array `arr`, the prefix sum `prefix[i]` = `arr[0] + arr[1] + ... + arr[i]`.

### When to Use

- Calculate sum of elements in a range `[i, j]` in O(1) time
- Optimize repeated range sum queries
- Solve problems involving subarray sums

### Time & Space Complexity

| Operation | Time | Space |
|-----------|------|-------|
| Build prefix array | O(n) | O(n) |
| Query range sum | O(1) | - |

### Implementation

#### Basic Prefix Sum

```python
def build_prefix_sum(arr):
    """
    Build prefix sum array.
    prefix[i] = sum of arr[0..i]
    """
    n = len(arr)
    prefix = [0] * (n + 1)  # Extra space to handle edge cases
    
    for i in range(n):
        prefix[i + 1] = prefix[i] + arr[i]
    
    return prefix

def range_sum(prefix, left, right):
    """
    Query sum of elements from index left to right (inclusive).
    Time: O(1)
    """
    return prefix[right + 1] - prefix[left]

# Example Usage
arr = [1, 2, 3, 4, 5]
prefix = build_prefix_sum(arr)

print(f"Prefix array: {prefix}")  # [0, 1, 3, 6, 10, 15]
print(f"Sum[1, 3]: {range_sum(prefix, 1, 3)}")  # 2 + 3 + 4 = 9
```

#### Prefix Sum with Offset Indexing

```python
def build_prefix_sum_indexed(arr):
    """
    Prefix sum where prefix[i] represents sum up to index i-1.
    Useful for 1-indexed problems.
    """
    n = len(arr)
    prefix = [0] * (n + 1)
    
    for i in range(1, n + 1):
        prefix[i] = prefix[i - 1] + arr[i - 1]
    
    return prefix

# Query: sum from index i to j (1-indexed)
def range_sum_1indexed(prefix, i, j):
    return prefix[j] - prefix[i - 1]
```

#### Example: Subarray Sum Equals K

```python
def subarraySum(arr, k):
    """
    Find number of subarrays with sum equal to k.
    Time: O(n), Space: O(n)
    """
    prefix_sum = 0
    sum_count = {0: 1}  # Initialize with 0 sum occurring once
    result = 0
    
    for num in arr:
        prefix_sum += num
        # If (prefix_sum - k) exists, we found subarrays ending here with sum k
        if prefix_sum - k in sum_count:
            result += sum_count[prefix_sum - k]
        
        # Add current prefix sum to map
        sum_count[prefix_sum] = sum_count.get(prefix_sum, 0) + 1
    
    return result

# Test
arr = [1, 1, 1]
print(subarraySum(arr, 2))  # Output: 2 (indices [0,1] and [1,2])
```

---

## Difference Arrays

### Concept

A difference array stores the differences between consecutive elements. To apply range updates efficiently, we modify only the boundaries instead of all elements in the range.

### When to Use

- Apply range updates efficiently (add/subtract value to all elements in range)
- Optimize multiple range update operations
- Reconstruct original array after updates

### Time & Space Complexity

| Operation | Time | Space |
|-----------|------|-------|
| Build difference array | O(n) | O(n) |
| Range update | O(1) | - |
| Reconstruct array | O(n) | - |

### Implementation

#### Basic Difference Array

```python
def range_update(diff, left, right, val):
    """
    Add val to all elements in range [left, right].
    Time: O(1)
    
    Args:
        diff: Difference array
        left, right: Range (inclusive)
        val: Value to add
    """
    diff[left] += val
    if right + 1 < len(diff):
        diff[right + 1] -= val

def reconstruct_array(diff):
    """
    Reconstruct original array from difference array.
    Time: O(n)
    """
    result = []
    current = 0
    
    for d in diff:
        current += d
        result.append(current)
    
    return result

# Example Usage
n = 5
diff = [0] * (n + 1)  # Extra space for boundary

# Add 2 to range [1, 3]
range_update(diff, 1, 3, 2)
# Add 3 to range [0, 2]
range_update(diff, 0, 2, 3)

print(f"Difference array: {diff}")  # [3, 2, 2, -2, -3, -3]
print(f"Reconstructed: {reconstruct_array(diff)}")  # [3, 5, 7, 5, 2]
```

#### With Initial Array

```python
def build_difference_array(arr):
    """Build difference array from original array."""
    n = len(arr)
    diff = [0] * (n + 1)
    
    for i in range(n):
        diff[i + 1] = arr[i] - (arr[i - 1] if i > 0 else 0)
    
    return diff

def apply_updates_and_get_result(arr, updates):
    """
    Apply multiple range updates efficiently.
    updates: List of [left, right, val] tuples
    """
    n = len(arr)
    diff = [0] * (n + 1)
    
    # Build initial difference array
    for i in range(n):
        diff[i + 1] = arr[i] - (arr[i - 1] if i > 0 else 0)
    
    # Apply all updates
    for left, right, val in updates:
        range_update(diff, left, right, val)
    
    # Reconstruct and return
    return reconstruct_array(diff)

# Test
arr = [1, 2, 3, 4, 5]
updates = [(1, 3, 2), (0, 2, -1)]
result = apply_updates_and_get_result(arr, updates)
print(result)  # Modified array after all updates
```

#### Example: Optimal Account Balancing with Range Updates

```python
def maxEvents(arr):
    """
    Given array of events at different times and their values.
    For each position, find sum of all event values affecting that position.
    """
    n = len(arr)
    events = sorted(arr, key=lambda x: x[0])  # Sort by time
    
    result = []
    diff = [0] * (n + 1)
    
    for start, end, val in events:
        # Add val to range [start, end]
        if start < n:
            diff[start] += val
        if end + 1 < n:
            diff[end + 1] -= val
    
    # Reconstruct to get cumulative values
    current = 0
    for i in range(n):
        current += diff[i]
        result.append(current)
    
    return result
```

---

## 2D Prefix Sums

### Concept

Extends prefix sums to 2D arrays for efficient rectangular region sum queries.

### Implementation

```python
def build_2d_prefix_sum(matrix):
    """
    Build 2D prefix sum array.
    prefix[i][j] = sum of all elements in rectangle from (0,0) to (i-1,j-1)
    """
    m, n = len(matrix), len(matrix[0])
    prefix = [[0] * (n + 1) for _ in range(m + 1)]
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            prefix[i][j] = (matrix[i-1][j-1] +
                           prefix[i-1][j] +
                           prefix[i][j-1] -
                           prefix[i-1][j-1])
    
    return prefix

def query_2d_sum(prefix, r1, c1, r2, c2):
    """
    Query sum of rectangle from (r1, c1) to (r2, c2) (inclusive, 0-indexed).
    Time: O(1)
    """
    return (prefix[r2+1][c2+1] -
            prefix[r1][c2+1] -
            prefix[r2+1][c1] +
            prefix[r1][c1])

# Example Usage
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

prefix = build_2d_prefix_sum(matrix)
print(query_2d_sum(prefix, 0, 0, 1, 1))  # Sum of [[1,2],[4,5]] = 12
print(query_2d_sum(prefix, 1, 1, 2, 2))  # Sum of [[5,6],[8,9]] = 28
```

#### 2D Difference Array

```python
def apply_2d_range_update(diff, r1, c1, r2, c2, val):
    """
    Add val to all elements in rectangle [r1, c1] to [r2, c2].
    Time: O(1)
    """
    diff[r1][c1] += val
    diff[r1][c2 + 1] -= val
    diff[r2 + 1][c1] -= val
    diff[r2 + 1][c2 + 1] += val

def reconstruct_2d_array(diff):
    """
    Reconstruct 2D array from difference array.
    Time: O(m*n)
    """
    m, n = len(diff), len(diff[0])
    result = [[0] * n for _ in range(m)]
    
    for i in range(m):
        for j in range(n):
            result[i][j] = diff[i][j]
            if i > 0:
                result[i][j] += result[i-1][j]
            if j > 0:
                result[i][j] += result[i][j-1]
            if i > 0 and j > 0:
                result[i][j] -= result[i-1][j-1]
    
    return result
```

---

## Common Patterns

### Pattern 1: Running Sum with Prefix Array

```python
def running_sum(nums):
    """Classic running sum using prefix sums."""
    result = []
    prefix = 0
    for num in nums:
        prefix += num
        result.append(prefix)
    return result
```

### Pattern 2: Subarray Sum Constraint

```python
def number_of_subarrays(arr, k):
    """
    Count subarrays with sum equal to k using prefix sum + hash map.
    """
    count = {0: 1}
    prefix_sum = 0
    result = 0
    
    for num in arr:
        prefix_sum += num
        if prefix_sum - k in count:
            result += count[prefix_sum - k]
        count[prefix_sum] = count.get(prefix_sum, 0) + 1
    
    return result
```

### Pattern 3: Continuous Update Query

```python
class RangeUpdateQueryArray:
    """Handle multiple range updates and point queries efficiently."""
    
    def __init__(self, n):
        self.diff = [0] * (n + 1)
        self.n = n
    
    def range_update(self, left, right, val):
        """Add val to range [left, right]."""
        self.diff[left] += val
        if right + 1 <= self.n:
            self.diff[right + 1] -= val
    
    def query(self, idx):
        """Get value at index idx after all updates."""
        result = 0
        for i in range(idx + 1):
            result += self.diff[i]
        return result
    
    def get_all_values(self):
        """Get all values after all updates. Time: O(n)"""
        result = []
        current = 0
        for i in range(self.n):
            current += self.diff[i]
            result.append(current)
        return result
```

---

## Problems & Solutions

### Problem 1: Range Sum Query - Immutable

**Problem**: Given an array, answer multiple range sum queries efficiently.

```python
class NumArray:
    def __init__(self, nums):
        self.prefix = [0]
        for num in nums:
            self.prefix.append(self.prefix[-1] + num)
    
    def sumRange(self, left: int, right: int) -> int:
        return self.prefix[right + 1] - self.prefix[left]

# Test
obj = NumArray([-2, 0, 3, -5, 2, -1])
print(obj.sumRange(0, 2))  # Output: 1 (sum of -2+0+3)
print(obj.sumRange(2, 5))  # Output: -1 (sum of 3-5+2-1)
```

### Problem 2: Increment Array Ranges

**Problem**: Apply multiple range increments, then return final array.

```python
def getModifiedArray(length, updates):
    """
    Apply range updates efficiently using difference array.
    updates: List of [startIndex, endIndex, inc]
    """
    diff = [0] * (length + 1)
    
    for start, end, inc in updates:
        diff[start] += inc
        diff[end + 1] -= inc
    
    result = []
    current = 0
    for i in range(length):
        current += diff[i]
        result.append(current)
    
    return result

# Test
updates = [[1, 3, 2], [2, 4, 3], [0, 2, -2]]
print(getModifiedArray(5, updates))  # Output: [-2, 0, 3, 5, 3]
```

### Problem 3: Maximal Rectangle

**Problem**: Find largest rectangle of 1s in binary matrix.

```python
def maximal_rectangle(matrix):
    """
    Find area of largest rectangle containing only 1s.
    Uses 2D prefix sum + histogram approach.
    """
    if not matrix:
        return 0
    
    m, n = len(matrix), len(matrix[0])
    heights = [0] * n
    max_area = 0
    
    for i in range(m):
        # Build histogram for current row
        for j in range(n):
            if matrix[i][j] == '1':
                heights[j] += 1
            else:
                heights[j] = 0
        
        # Find max rectangle in histogram
        max_area = max(max_area, largest_rectangle_in_histogram(heights))
    
    return max_area

def largest_rectangle_in_histogram(heights):
    """Helper: Find largest rectangle in histogram."""
    stack = []
    max_area = 0
    
    for i, h in enumerate(heights):
        start = i
        while stack and stack[-1][1] > h:
            idx, height = stack.pop()
            max_area = max(max_area, height * (i - idx))
            start = idx
        if h:
            stack.append((start, h))
    
    for idx, height in stack:
        max_area = max(max_area, height * (len(heights) - idx))
    
    return max_area
```

### Problem 4: Account Balance After Rounded Purchase

**Problem**: Track account balance with purchases and cashback.

```python
def account_balance_after_purchases(initial_balance, purchases, cashback_rate):
    """
    Simulate account balance with cumulative purchase tracking.
    Uses prefix sum to calculate running balance.
    """
    balance = initial_balance
    transactions = []
    
    for purchase in purchases:
        balance -= purchase
        cashback = int(purchase * cashback_rate / 100)
        balance += cashback
        transactions.append({
            'purchase': purchase,
            'cashback': cashback,
            'balance': balance
        })
    
    return transactions
```

---

## Interview Tips

### 1. **Problem Recognition**
- Look for "range sum", "range update", "continuous queries"
- Multiple queries on same array = prefix sum candidate
- Multiple updates on same array = difference array candidate

### 2. **Edge Cases to Handle**
```python
# Always check boundaries
# Remember to add extra space for difference arrays
# 0-indexed vs 1-indexed mismatch
# Empty arrays or single element
```

### 3. **Space-Time Tradeoff**
```
Prefix Sum:
- Space: O(n)
- Build: O(n)
- Query: O(1)

Naive Approach:
- Space: O(1)
- Build: O(1)
- Query: O(n)

Use prefix sums when queries >> array updates
```

### 4. **Common Mistakes**
- **Off-by-one errors**: Be careful with inclusive/exclusive ranges
- **Forgetting to initialize**: Don't forget padding in difference arrays
- **Wrong reconstruction**: Ensure you apply updates correctly

### 5. **Optimization Tips**
```python
# Combine approaches
# Multiple prefix sums for different properties
# Use hash maps with prefix sums for subarray problems
# Consider 2D prefix sums for matrix problems early
```

### 6. **Code Template**

```python
# Prefix Sum Template
def solve_with_prefix_sum(arr, queries):
    # Build prefix
    prefix = [0]
    for num in arr:
        prefix.append(prefix[-1] + num)
    
    # Answer queries
    results = []
    for left, right in queries:
        results.append(prefix[right + 1] - prefix[left])
    
    return results

# Difference Array Template
def solve_with_difference(n, operations):
    # Initialize
    diff = [0] * (n + 1)
    
    # Apply operations
    for left, right, val in operations:
        diff[left] += val
        diff[right + 1] -= val
    
    # Reconstruct
    result = []
    current = 0
    for i in range(n):
        current += diff[i]
        result.append(current)
    
    return result
```

---

## Practice Problems

1. **LeetCode 303**: Range Sum Query - Immutable
2. **LeetCode 304**: Range Sum Query 2D - Immutable
3. **LeetCode 1109**: Corporate Flight Bookings
4. **LeetCode 1094**: Car Pooling
5. **LeetCode 2381**: Shifting Letters
6. **LeetCode 995**: Minimum Number of K Consecutive Bit Flips
7. **LeetCode 1477**: Find Two Non-overlapping Sub-arrays Each With Target Sum
8. **LeetCode 560**: Subarray Sum Equals K

---

## Resources

- Prefix Sum Visualization: [GeeksforGeeks](https://www.geeksforgeeks.org/prefix-sum-array-implementation-applications-competitive-programming/)
- Difference Array Guide: [InterviewBit](https://www.interviewbit.com/courses/programming/topics/arrays/)
- Range Updates: [Codeforces](https://codeforces.com/)

---

**Last Updated**: 2025-12-15
