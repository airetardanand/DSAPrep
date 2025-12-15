# Pattern 10: Dynamic Programming (2D)

## Overview

2D Dynamic Programming extends DP concepts to problems requiring two-dimensional state representation, typically involving strings, matrices, or pairwise relationships.

## Core Concepts

- **State**: dp[i][j] represents solution to subproblem
- **Transitions**: Based on dp[i-1][j], dp[i][j-1], dp[i-1][j-1]
- **Space Optimization**: Often reducible to O(n) space

## Key Problems

### Problem 1: Unique Paths (LeetCode 62)

```python
def uniquePaths(m, n):
    """
    Count unique paths from top-left to bottom-right.
    Can only move right or down.
    
    Time: O(m*n), Space: O(n)
    """
    # Space-optimized: only keep current row
    dp = [1] * n
    
    for i in range(1, m):
        for j in range(1, n):
            dp[j] += dp[j-1]
    
    return dp[n-1]

print(uniquePaths(3, 7))  # 28
```

### Problem 2: Longest Common Subsequence (LeetCode 1143)

```python
def longestCommonSubsequence(text1, text2):
    """
    Find length of longest common subsequence.
    
    Time: O(m*n), Space: O(m*n)
    """
    m, n = len(text1), len(text2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    
    return dp[m][n]

print(longestCommonSubsequence("abcde", "ace"))  # 3
```

### Problem 3: Edit Distance (LeetCode 72)

```python
def minDistance(word1, word2):
    """
    Minimum operations to convert word1 to word2.
    Operations: insert, delete, replace
    
    Time: O(m*n), Space: O(m*n)
    """
    m, n = len(word1), len(word2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Initialize base cases
    for i in range(m + 1):
        dp[i][0] = i
    for j in range(n + 1):
        dp[0][j] = j
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if word1[i-1] == word2[j-1]:
                dp[i][j] = dp[i-1][j-1]
            else:
                dp[i][j] = 1 + min(
                    dp[i-1][j],    # delete
                    dp[i][j-1],    # insert
                    dp[i-1][j-1]   # replace
                )
    
    return dp[m][n]

print(minDistance("horse", "ros"))  # 3
```

### Problem 4: 0/1 Knapsack

```python
def knapsack(weights, values, capacity):
    """
    0/1 Knapsack: maximize value with weight constraint.
    
    Time: O(n*W), Space: O(n*W)
    """
    n = len(weights)
    dp = [[0] * (capacity + 1) for _ in range(n + 1)]
    
    for i in range(1, n + 1):
        for w in range(capacity + 1):
            if weights[i-1] <= w:
                dp[i][w] = max(
                    values[i-1] + dp[i-1][w-weights[i-1]],
                    dp[i-1][w]
                )
            else:
                dp[i][w] = dp[i-1][w]
    
    return dp[n][capacity]

print(knapsack([1, 2, 3], [6, 10, 12], 5))  # 22
```

### Problem 5: Minimum Path Sum (LeetCode 64)

```python
def minPathSum(grid):
    """
    Find path with minimum sum from top-left to bottom-right.
    
    Time: O(m*n), Space: O(n)
    """
    m, n = len(grid), len(grid[0])
    dp = [float('inf')] * n
    dp[0] = 0
    
    for i in range(m):
        dp[0] = dp[0] + grid[i][0]
        for j in range(1, n):
            dp[j] = min(dp[j], dp[j-1]) + grid[i][j]
    
    return dp[n-1]

print(minPathSum([[1,3,1],[1,5,1],[4,2,1]]))  # 7
```

## Common Patterns

1. **Grid DP**: Unique paths, minimum path sum
2. **String DP**: LCS, edit distance, wildcard matching
3. **Knapsack**: 0/1, unbounded, multiple constraints
4. **Range DP**: Burst balloons, merge stones

## Interview Tips

- Draw 2D table to visualize
- Identify base cases clearly
- Consider space optimization (rolling array)
- Watch out for off-by-one errors

## Summary

| Aspect | Details |
|--------|---------|
| **Complexity** | O(m*n) time, often O(n) space |
| **Difficulty** | Medium to Hard |
| **Key Skill** | State definition and transition |
