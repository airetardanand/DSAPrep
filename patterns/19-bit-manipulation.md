# Pattern 19: Bit Manipulation

## Overview
Bit manipulation uses bitwise operators for efficient computations on binary representations.

## Common Operations
```python
# Check if kth bit is set
def is_bit_set(n, k):
    return (n & (1 << k)) != 0

# Set kth bit
def set_bit(n, k):
    return n | (1 << k)

# Clear kth bit
def clear_bit(n, k):
    return n & ~(1 << k)

# Toggle kth bit
def toggle_bit(n, k):
    return n ^ (1 << k)

# Get rightmost set bit
def rightmost_set_bit(n):
    return n & -n

# Count set bits
def count_bits(n):
    count = 0
    while n:
        n &= n - 1  # Clear rightmost bit
        count += 1
    return count
```

## Key Problems

### Single Number (LeetCode 136)
```python
def singleNumber(nums):
    """Every element appears twice except one."""
    result = 0
    for num in nums:
        result ^= num
    return result

print(singleNumber([2,2,1]))  # 1
```

### Power of Two (LeetCode 231)
```python
def isPowerOfTwo(n):
    """Check if n is power of 2."""
    return n > 0 and (n & (n - 1)) == 0

print(isPowerOfTwo(16))  # True
```

### Subsets (using bit manipulation)
```python
def subsets(nums):
    n = len(nums)
    result = []
    for mask in range(1 << n):  # 2^n subsets
        subset = []
        for i in range(n):
            if mask & (1 << i):
                subset.append(nums[i])
        result.append(subset)
    return result
```

## Summary
- **Use**: Flags, set operations, optimization
- **Complexity**: Usually O(1) per operation
- **Key**: XOR for finding unique, AND/OR for masking
"""
