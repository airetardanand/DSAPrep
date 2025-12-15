# Pattern 30: Advanced Pattern Problems

## Overview
Problems combining multiple patterns and advanced techniques.

## Mixed Patterns

### Trapping Rain Water (LeetCode 42)
Combines: Two pointers, DP
```python
def trap(height):
    """
    Calculate trapped rain water.
    
    Time: O(n), Space: O(1)
    """
    left, right = 0, len(height) - 1
    left_max = right_max = water = 0
    
    while left < right:
        if height[left] < height[right]:
            if height[left] >= left_max:
                left_max = height[left]
            else:
                water += left_max - height[left]
            left += 1
        else:
            if height[right] >= right_max:
                right_max = height[right]
            else:
                water += right_max - height[right]
            right -= 1
    
    return water

print(trap([0,1,0,2,1,0,1,3,2,1,2,1]))  # 6
```

### Median of Two Sorted Arrays (LeetCode 4)
Combines: Binary search, merge
```python
def findMedianSortedArrays(nums1, nums2):
    """
    Find median of two sorted arrays.
    
    Time: O(log(min(m,n)))
    """
    if len(nums1) > len(nums2):
        nums1, nums2 = nums2, nums1
    
    m, n = len(nums1), len(nums2)
    left, right = 0, m
    
    while left <= right:
        i = (left + right) // 2
        j = (m + n + 1) // 2 - i
        
        max_left1 = float('-inf') if i == 0 else nums1[i-1]
        min_right1 = float('inf') if i == m else nums1[i]
        max_left2 = float('-inf') if j == 0 else nums2[j-1]
        min_right2 = float('inf') if j == n else nums2[j]
        
        if max_left1 <= min_right2 and max_left2 <= min_right1:
            if (m + n) % 2 == 0:
                return (max(max_left1, max_left2) + min(min_right1, min_right2)) / 2
            return max(max_left1, max_left2)
        elif max_left1 > min_right2:
            right = i - 1
        else:
            left = i + 1
```

### Regular Expression Matching (LeetCode 10)
Combines: DP, recursion
```python
def isMatch(s, p):
    """
    Pattern matching with '.' and '*'.
    
    Time: O(m*n), Space: O(m*n)
    """
    m, n = len(s), len(p)
    dp = [[False] * (n + 1) for _ in range(m + 1)]
    dp[0][0] = True
    
    # Handle patterns like a*, a*b*, a*b*c*
    for j in range(2, n + 1):
        if p[j-1] == '*':
            dp[0][j] = dp[0][j-2]
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if p[j-1] == '*':
                dp[i][j] = dp[i][j-2]  # Match zero
                if p[j-2] == '.' or p[j-2] == s[i-1]:
                    dp[i][j] |= dp[i-1][j]  # Match one or more
            elif p[j-1] == '.' or p[j-1] == s[i-1]:
                dp[i][j] = dp[i-1][j-1]
    
    return dp[m][n]
```

## Optimization Techniques

### Sliding Window + Monotonic Deque
### Binary Search + DP
### Trie + Backtracking
### Union-Find + Graph

## Interview Tips
1. Identify multiple patterns in problem
2. Start with brute force
3. Optimize step by step
4. Consider space-time tradeoffs

## Summary
Advanced problems require:
- Pattern recognition
- Multiple technique combination
- Optimization skills
- Clean code under pressure
"""
