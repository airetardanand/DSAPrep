# Pattern 9: Dynamic Programming (1D)

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

Dynamic Programming (DP) is an optimization technique that solves complex problems by breaking them into simpler subproblems and storing results to avoid redundant computations. 1D DP focuses on problems where state depends on a single dimension.

**Key Concepts:**
- Overlapping subproblems
- Optimal substructure
- Memoization (top-down) or Tabulation (bottom-up)

**Common Applications:**
- Fibonacci sequence
- Climbing stairs
- House robber
- Longest Increasing Subsequence
- Coin change
- Decode ways

## Pattern Variations

### 1. **Linear DP (Array-based)**
- State: dp[i] depends on previous states
- **Time**: O(n), **Space**: O(n) or O(1)

### 2. **State Machine DP**
- Multiple states at each position
- **Time**: O(n * k), k = number of states

### 3. **Optimization DP**
- Minimize or maximize some value
- **Time**: O(n) or O(n²)

---

## Core Concepts

### DP Problem Checklist

✓ **Has optimal substructure?**
   - Can problem be broken into smaller subproblems?
   - Optimal solution built from optimal subproblems?

✓ **Has overlapping subproblems?**
   - Same subproblems computed multiple times?
   - Can we cache and reuse results?

### Two Approaches

1. **Top-Down (Memoization)**
   - Recursive with caching
   - Natural to think about
   - Extra space for recursion stack

2. **Bottom-Up (Tabulation)**
   - Iterative with array
   - More space efficient
   - Better constants

---

## Detailed Implementations

### Problem 1: Climbing Stairs (LeetCode 70)

```python
def climbStairs(n):
    """
    LeetCode 70: Climbing Stairs
    
    You can climb 1 or 2 steps at a time.
    How many distinct ways to climb to the top?
    
    Args:
        n: Number of stairs
    
    Returns:
        Number of distinct ways
    
    Time: O(n), Space: O(1)
    
    Example:
        Input: n = 3
        Output: 3 (1+1+1, 1+2, 2+1)
    """
    if n <= 2:
        return n
    
    # Bottom-up DP with O(1) space
    prev2 = 1  # n = 1
    prev1 = 2  # n = 2
    
    for i in range(3, n + 1):
        current = prev1 + prev2
        prev2 = prev1
        prev1 = current
    
    return prev1

# Test cases
print(climbStairs(2))  # 2
print(climbStairs(3))  # 3
print(climbStairs(5))  # 8
```

### Problem 2: House Robber (LeetCode 198)

```python
def rob(nums):
    """
    LeetCode 198: House Robber
    
    Rob houses to maximize money. Can't rob adjacent houses.
    
    Args:
        nums: Array of money in each house
    
    Returns:
        Maximum amount that can be robbed
    
    Time: O(n), Space: O(1)
    
    Example:
        Input: [1,2,3,1]
        Output: 4 (rob house 0 and 2)
    """
    if not nums:
        return 0
    if len(nums) == 1:
        return nums[0]
    
    # dp[i] = max money robbing up to house i
    # dp[i] = max(dp[i-1], dp[i-2] + nums[i])
    
    prev2 = 0
    prev1 = nums[0]
    
    for i in range(1, len(nums)):
        current = max(prev1, prev2 + nums[i])
        prev2 = prev1
        prev1 = current
    
    return prev1

# Test cases
print(rob([1, 2, 3, 1]))        # 4
print(rob([2, 7, 9, 3, 1]))     # 12
print(rob([2, 1, 1, 2]))        # 4
```

### Problem 3: Coin Change (LeetCode 322)

```python
def coinChange(coins, amount):
    """
    LeetCode 322: Coin Change
    
    Find minimum number of coins to make amount.
    
    Args:
        coins: Array of coin denominations
        amount: Target amount
    
    Returns:
        Minimum coins needed, or -1 if impossible
    
    Time: O(amount * len(coins)), Space: O(amount)
    
    Example:
        Input: coins = [1,2,5], amount = 11
        Output: 3 (11 = 5 + 5 + 1)
    """
    dp = [float('inf')] * (amount + 1)
    dp[0] = 0
    
    for i in range(1, amount + 1):
        for coin in coins:
            if coin <= i:
                dp[i] = min(dp[i], dp[i - coin] + 1)
    
    return dp[amount] if dp[amount] != float('inf') else -1

# Test cases
print(coinChange([1, 2, 5], 11))    # 3
print(coinChange([2], 3))           # -1
print(coinChange([1], 0))           # 0
```

### Problem 4: Longest Increasing Subsequence (LeetCode 300)

```python
def lengthOfLIS(nums):
    """
    LeetCode 300: Longest Increasing Subsequence
    
    Find length of longest strictly increasing subsequence.
    
    Args:
        nums: Array of integers
    
    Returns:
        Length of LIS
    
    Time: O(n²), Space: O(n)
    Better: O(n log n) with binary search
    
    Example:
        Input: [10,9,2,5,3,7,101,18]
        Output: 4 (LIS: [2,3,7,101])
    """
    if not nums:
        return 0
    
    n = len(nums)
    dp = [1] * n
    
    for i in range(1, n):
        for j in range(i):
            if nums[j] < nums[i]:
                dp[i] = max(dp[i], dp[j] + 1)
    
    return max(dp)

# Test cases
print(lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]))  # 4
print(lengthOfLIS([0, 1, 0, 3, 2, 3]))            # 4
print(lengthOfLIS([7, 7, 7, 7, 7, 7, 7]))         # 1
```

### Problem 5: Decode Ways (LeetCode 91)

```python
def numDecodings(s):
    """
    LeetCode 91: Decode Ways
    
    'A' -> 1, 'B' -> 2, ..., 'Z' -> 26
    Count number of ways to decode the string.
    
    Args:
        s: String of digits
    
    Returns:
        Number of ways to decode
    
    Time: O(n), Space: O(1)
    
    Example:
        Input: "12"
        Output: 2 ("AB" or "L")
    """
    if not s or s[0] == '0':
        return 0
    
    n = len(s)
    prev2 = 1  # Empty string
    prev1 = 1  # First character
    
    for i in range(1, n):
        current = 0
        
        # Single digit decode
        if s[i] != '0':
            current += prev1
        
        # Two digit decode
        two_digit = int(s[i-1:i+1])
        if 10 <= two_digit <= 26:
            current += prev2
        
        prev2 = prev1
        prev1 = current
    
    return prev1

# Test cases
print(numDecodings("12"))      # 2
print(numDecodings("226"))     # 3
print(numDecodings("06"))      # 0
```

### Problem 6: Maximum Product Subarray (LeetCode 152)

```python
def maxProduct(nums):
    """
    LeetCode 152: Maximum Product Subarray
    
    Find contiguous subarray with largest product.
    
    Args:
        nums: Array of integers
    
    Returns:
        Maximum product
    
    Time: O(n), Space: O(1)
    
    Example:
        Input: [2,3,-2,4]
        Output: 6 (subarray [2,3])
    """
    if not nums:
        return 0
    
    max_prod = min_prod = result = nums[0]
    
    for i in range(1, len(nums)):
        num = nums[i]
        
        # If num is negative, swap max and min
        if num < 0:
            max_prod, min_prod = min_prod, max_prod
        
        max_prod = max(num, max_prod * num)
        min_prod = min(num, min_prod * num)
        
        result = max(result, max_prod)
    
    return result

# Test cases
print(maxProduct([2, 3, -2, 4]))      # 6
print(maxProduct([-2, 0, -1]))        # 0
print(maxProduct([-2, 3, -4]))        # 24
```

### Problem 7: Word Break (LeetCode 139)

```python
def wordBreak(s, wordDict):
    """
    LeetCode 139: Word Break
    
    Can string be segmented into dictionary words?
    
    Args:
        s: String to segment
        wordDict: List of valid words
    
    Returns:
        True if can be segmented
    
    Time: O(n² * m), Space: O(n)
    n = len(s), m = len(wordDict)
    
    Example:
        Input: s = "leetcode", wordDict = ["leet","code"]
        Output: True
    """
    word_set = set(wordDict)
    n = len(s)
    dp = [False] * (n + 1)
    dp[0] = True  # Empty string
    
    for i in range(1, n + 1):
        for j in range(i):
            if dp[j] and s[j:i] in word_set:
                dp[i] = True
                break
    
    return dp[n]

# Test cases
print(wordBreak("leetcode", ["leet", "code"]))      # True
print(wordBreak("applepenapple", ["apple", "pen"])) # True
print(wordBreak("catsandog", ["cats", "dog", "sand", "and", "cat"]))  # False
```

---

## Complexity Analysis

| Problem | Time | Space | Note |
|---------|------|-------|------|
| Climbing Stairs | O(n) | O(1) | Fibonacci-like |
| House Robber | O(n) | O(1) | Space optimized |
| Coin Change | O(n*m) | O(n) | n=amount, m=coins |
| LIS | O(n²) | O(n) | Can optimize to O(n log n) |
| Decode Ways | O(n) | O(1) | Space optimized |

---

## Common Pitfalls

### Pitfall 1: Not Handling Base Cases

```python
# ❌ WRONG: Missing base cases
def dp_problem(n):
    dp = [0] * n  # Crashes if n = 0!
    dp[0] = 1

# ✓ CORRECT
def dp_problem(n):
    if n == 0:
        return 0
    dp = [0] * n
    dp[0] = 1
```

### Pitfall 2: Wrong Transition

```python
# ❌ WRONG: Incorrect recurrence relation
dp[i] = dp[i-1] + nums[i]  # Doesn't consider all options

# ✓ CORRECT: Consider all valid transitions
dp[i] = max(dp[i-1], dp[i-2] + nums[i])
```

---

## Interview Tips

1. **Identify DP pattern**: Look for overlapping subproblems
2. **Define state**: What does dp[i] represent?
3. **Find recurrence**: How to build dp[i] from previous states?
4. **Initialize base cases**: What are smallest subproblems?
5. **Determine order**: Fill table in what order?
6. **Optimize space**: Can we use O(1) space?

---

## Summary

| Aspect | Details |
|--------|---------|
| **When to use** | Optimization, counting, overlapping subproblems |
| **Complexity** | Usually O(n) or O(n²) time |
| **Space** | O(n) or can optimize to O(1) |
| **Difficulty** | Medium to Hard |

**Related Patterns:**
- 2D Dynamic Programming (extends to 2D)
- Backtracking (explores all solutions)
- Greedy (sometimes alternative to DP)
