# Pattern 22: Queue & Monotonic Deque

## Overview
Monotonic deques maintain elements in monotonic order, useful for sliding window maximum/minimum.

## Key Problem: Sliding Window Maximum (LeetCode 239)
```python
from collections import deque

def maxSlidingWindow(nums, k):
    """
    Find maximum in each sliding window of size k.
    
    Time: O(n), Space: O(k)
    """
    dq = deque()  # Stores indices
    result = []
    
    for i in range(len(nums)):
        # Remove elements outside window
        while dq and dq[0] < i - k + 1:
            dq.popleft()
        
        # Remove smaller elements (they won't be max)
        while dq and nums[dq[-1]] < nums[i]:
            dq.pop()
        
        dq.append(i)
        
        # Add to result once window is full
        if i >= k - 1:
            result.append(nums[dq[0]])
    
    return result

print(maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3))  # [3,3,5,5,6,7]
```

## Template: Sliding Window with Deque
```python
def sliding_window_template(arr, k):
    dq = deque()
    result = []
    
    for i in range(len(arr)):
        # Remove out of window
        while dq and dq[0] <= i - k:
            dq.popleft()
        
        # Maintain monotonic property
        while dq and arr[dq[-1]] < arr[i]:  # Adjust comparison for min/max
            dq.pop()
        
        dq.append(i)
        
        if i >= k - 1:
            result.append(arr[dq[0]])
    
    return result
```

## Summary
- **Use**: Sliding window min/max
- **Complexity**: O(n) time (each element added/removed once)
"""
