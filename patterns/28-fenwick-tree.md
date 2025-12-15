# Pattern 28: Binary Indexed Tree (Fenwick Tree)

## Overview
Fenwick Tree (BIT) efficiently computes prefix sums with updates.

## Implementation
```python
class FenwickTree:
    def __init__(self, n):
        self.size = n
        self.tree = [0] * (n + 1)
    
    def update(self, idx, delta):
        """Add delta to element at idx. Time: O(log n)"""
        idx += 1  # 1-indexed
        while idx <= self.size:
            self.tree[idx] += delta
            idx += idx & (-idx)
    
    def query(self, idx):
        """Prefix sum up to idx. Time: O(log n)"""
        idx += 1  # 1-indexed
        result = 0
        while idx > 0:
            result += self.tree[idx]
            idx -= idx & (-idx)
        return result
    
    def range_query(self, left, right):
        """Sum of range [left, right]. Time: O(log n)"""
        if left > 0:
            return self.query(right) - self.query(left - 1)
        return self.query(right)

# Usage
bit = FenwickTree(5)
bit.update(0, 1)
bit.update(1, 2)
bit.update(2, 3)
print(bit.range_query(0, 2))  # 6
bit.update(1, 3)  # Now arr[1] = 5
print(bit.range_query(0, 2))  # 9
```

## Key Problem: Range Sum Query Mutable (LeetCode 307)
```python
class NumArray:
    def __init__(self, nums):
        self.nums = nums
        self.bit = FenwickTree(len(nums))
        for i, num in enumerate(nums):
            self.bit.update(i, num)
    
    def update(self, index, val):
        delta = val - self.nums[index]
        self.nums[index] = val
        self.bit.update(index, delta)
    
    def sumRange(self, left, right):
        return self.bit.range_query(left, right)
```

## Summary
- **Operations**: O(log n)
- **Space**: O(n)
- **vs Segment Tree**: Simpler, uses less memory, but less flexible
"""
