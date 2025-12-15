# Pattern 21: Stack & Monotonic Stack

## Overview
Monotonic stacks maintain elements in monotonic order, useful for finding next/previous greater/smaller elements.

## Monotonic Stack Template
```python
def monotonic_stack(arr):
    """Find next greater element for each element."""
    n = len(arr)
    result = [-1] * n
    stack = []  # Stores indices
    
    for i in range(n):
        while stack and arr[stack[-1]] < arr[i]:
            idx = stack.pop()
            result[idx] = arr[i]
        stack.append(i)
    
    return result
```

## Key Problems

### Daily Temperatures (LeetCode 739)
```python
def dailyTemperatures(temperatures):
    n = len(temperatures)
    answer = [0] * n
    stack = []
    
    for i in range(n):
        while stack and temperatures[i] > temperatures[stack[-1]]:
            idx = stack.pop()
            answer[idx] = i - idx
        stack.append(i)
    
    return answer

print(dailyTemperatures([73,74,75,71,69,72,76,73]))  # [1,1,4,2,1,1,0,0]
```

### Next Greater Element I (LeetCode 496)
```python
def nextGreaterElement(nums1, nums2):
    next_greater = {}
    stack = []
    
    for num in nums2:
        while stack and stack[-1] < num:
            next_greater[stack.pop()] = num
        stack.append(num)
    
    return [next_greater.get(num, -1) for num in nums1]
```

### Largest Rectangle in Histogram (LeetCode 84)
```python
def largestRectangleArea(heights):
    stack = []
    max_area = 0
    heights.append(0)  # Sentinel
    
    for i, h in enumerate(heights):
        while stack and heights[stack[-1]] > h:
            height_idx = stack.pop()
            width = i if not stack else i - stack[-1] - 1
            max_area = max(max_area, heights[height_idx] * width)
        stack.append(i)
    
    return max_area

print(largestRectangleArea([2,1,5,6,2,3]))  # 10
```

## Summary
- **Use**: Next/previous greater/smaller, histogram problems
- **Complexity**: O(n) time, O(n) space
"""
