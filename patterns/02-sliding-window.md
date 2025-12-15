# Sliding Window Pattern Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Fixed Window Approach](#fixed-window-approach)
3. [Variable Window Approach](#variable-window-approach)
4. [Monotonic Window Approach](#monotonic-window-approach)
5. [Key Concepts](#key-concepts)
6. [Common Patterns](#common-patterns)
7. [Time & Space Complexity Analysis](#time--space-complexity-analysis)

---

## Introduction

The **Sliding Window** pattern is an optimization technique used to solve problems involving subarrays, substrings, or contiguous sequences. Instead of recalculating results from scratch for each window, we maintain a window and slide it across the data structure, updating calculations incrementally.

### When to Use Sliding Window:
- Finding subarrays/substrings with specific properties
- Maximum/minimum in a window
- Counting elements satisfying a condition
- Problems asking for "longest", "shortest", "maximum", "minimum" of contiguous elements

---

## Fixed Window Approach

### Overview
A fixed-size window slides across the array, and we calculate a result for each window position.

### Template
```python
def fixed_window(arr, k):
    """
    Calculate result for all fixed-size windows of size k
    """
    if len(arr) < k:
        return []
    
    # Calculate result for first window
    current_window = arr[:k]
    result = calculate(current_window)
    results = [result]
    
    # Slide the window
    for i in range(k, len(arr)):
        # Remove leftmost element
        current_window.remove(arr[i - k])
        # Add new rightmost element
        current_window.append(arr[i])
        # Update result
        result = calculate(current_window)
        results.append(result)
    
    return results
```

### Example 1: Maximum Sum of Subarray of Size K

```python
def max_sum_subarray(arr, k):
    """
    Find the maximum sum of any subarray of size k
    
    Time Complexity: O(n)
    Space Complexity: O(1)
    """
    if len(arr) < k:
        return 0
    
    # Calculate sum of first window
    window_sum = sum(arr[:k])
    max_sum = window_sum
    
    # Slide the window
    for i in range(k, len(arr)):
        # Remove leftmost element and add rightmost element
        window_sum = window_sum - arr[i - k] + arr[i]
        max_sum = max(max_sum, window_sum)
    
    return max_sum

# Example
arr = [1, 4, 2, 10, 2, 3, 1, 0, 20]
k = 4
print(max_sum_subarray(arr, k))  # Output: 24 (subarray [10, 2, 3, 1, 0, 20] is wrong, [10,2,3,1] = 16, actually [3,1,0,20]=24)
```

### Example 2: Moving Average

```python
def moving_average(arr, k):
    """
    Calculate moving average for all windows of size k
    
    Time Complexity: O(n)
    Space Complexity: O(n) for output
    """
    if len(arr) < k:
        return []
    
    window_sum = sum(arr[:k])
    averages = [window_sum / k]
    
    for i in range(k, len(arr)):
        window_sum = window_sum - arr[i - k] + arr[i]
        averages.append(window_sum / k)
    
    return averages

# Example
arr = [1, 3, 2, 6, -1, 4, 1, 8]
k = 3
print(moving_average(arr, k))  # Output: [2.0, 3.67, 2.33, 3.0, 1.33, 4.33]
```

### Example 3: Consecutive Numbers with Sum K

```python
def count_windows_with_sum(arr, k):
    """
    Count number of subarrays of size k with a specific sum
    
    Time Complexity: O(n)
    Space Complexity: O(1)
    """
    target_sum = k * (k + 1) // 2  # Sum of 1+2+...+k
    window_sum = sum(arr[:k])
    count = 1 if window_sum == target_sum else 0
    
    for i in range(k, len(arr)):
        window_sum = window_sum - arr[i - k] + arr[i]
        if window_sum == target_sum:
            count += 1
    
    return count
```

---

## Variable Window Approach

### Overview
The window size varies based on the problem conditions. We expand and contract the window as needed, maintaining a condition or constraint.

### Template
```python
def variable_window(arr, target_condition):
    """
    Find optimal window satisfying target_condition
    """
    left = 0
    result = float('-inf')
    
    for right in range(len(arr)):
        # Expand window by including arr[right]
        # Update window state
        
        # Contract window while condition is not satisfied
        while not target_condition():
            # Update window state by removing arr[left]
            left += 1
        
        # Update result with current valid window
        result = max(result, calculate(arr, left, right))
    
    return result
```

### Example 1: Longest Substring Without Repeating Characters

```python
def longest_substring_without_repeating(s):
    """
    Find length of longest substring without repeating characters
    
    Time Complexity: O(n)
    Space Complexity: O(min(n, m)) where m is charset size
    """
    char_index = {}
    left = 0
    max_length = 0
    
    for right in range(len(s)):
        # If character exists and is in current window
        if s[right] in char_index and char_index[s[right]] >= left:
            # Move left pointer to right of previous occurrence
            left = char_index[s[right]] + 1
        
        # Update character's latest index
        char_index[s[right]] = right
        
        # Update max length
        max_length = max(max_length, right - left + 1)
    
    return max_length

# Example
print(longest_substring_without_repeating("abcabcbb"))  # Output: 3 ("abc")
print(longest_substring_without_repeating("bbbbb"))     # Output: 1 ("b")
print(longest_substring_without_repeating("pwwkew"))    # Output: 3 ("wke")
```

### Example 2: Minimum Window Substring

```python
def min_window_substring(s, t):
    """
    Find minimum window in s that contains all characters in t
    
    Time Complexity: O(n + m) where n = len(s), m = len(t)
    Space Complexity: O(1) - at most 26 characters
    """
    if not s or not t or len(s) < len(t):
        return ""
    
    # Dictionary which keeps the count of all unique characters in t
    dict_t = {}
    for char in t:
        dict_t[char] = dict_t.get(char, 0) + 1
    
    formed = 0  # Number of unique characters in t satisfied
    window_counts = {}
    
    # Left and right pointers
    left = 0
    min_len = float('inf')
    min_left = 0
    
    for right in range(len(s)):
        # Add character from right to window
        char = s[right]
        window_counts[char] = window_counts.get(char, 0) + 1
        
        # If frequency of current character added equals to desired count then increment formed
        if char in dict_t and window_counts[char] == dict_t[char]:
            formed += 1
        
        # Try to contract the window until the point where it ceases to be 'desirable'
        while left <= right and formed == len(dict_t):
            char = s[left]
            
            # Save the smallest window
            if right - left + 1 < min_len:
                min_len = right - left + 1
                min_left = left
            
            # The character at the position pointed by the `left` pointer is no longer a part of the window
            window_counts[char] -= 1
            if char in dict_t and window_counts[char] < dict_t[char]:
                formed -= 1
            
            left += 1
    
    return "" if min_len == float('inf') else s[min_left:min_left + min_len]

# Example
print(min_window_substring("ADOBECODEBANC", "ABC"))  # Output: "BANC"
print(min_window_substring("a", "a"))                # Output: "a"
print(min_window_substring("abc", "cdc"))            # Output: ""
```

### Example 3: Longest Substring with At Most K Distinct Characters

```python
def longest_substring_with_k_distinct(s, k):
    """
    Find length of longest substring with at most k distinct characters
    
    Time Complexity: O(n)
    Space Complexity: O(min(n, k))
    """
    if k == 0 or not s:
        return 0
    
    char_count = {}
    left = 0
    max_length = 0
    
    for right in range(len(s)):
        # Add right character to window
        char = s[right]
        char_count[char] = char_count.get(char, 0) + 1
        
        # Shrink window while we have more than k distinct characters
        while len(char_count) > k:
            left_char = s[left]
            char_count[left_char] -= 1
            if char_count[left_char] == 0:
                del char_count[left_char]
            left += 1
        
        # Update max length
        max_length = max(max_length, right - left + 1)
    
    return max_length

# Example
print(longest_substring_with_k_distinct("eceba", 2))    # Output: 3 ("ece")
print(longest_substring_with_k_distinct("aa", 1))       # Output: 2 ("aa")
print(longest_substring_with_k_distinct("abc", 2))      # Output: 2 ("ab" or "bc")
```

### Example 4: Minimum Length of Subarray with Sum >= Target

```python
def min_subarray_length(target, arr):
    """
    Find minimum length of contiguous subarray with sum >= target
    
    Time Complexity: O(n)
    Space Complexity: O(1)
    """
    left = 0
    current_sum = 0
    min_length = float('inf')
    
    for right in range(len(arr)):
        # Expand window
        current_sum += arr[right]
        
        # Shrink window while sum >= target
        while current_sum >= target:
            min_length = min(min_length, right - left + 1)
            current_sum -= arr[left]
            left += 1
    
    return min_length if min_length != float('inf') else 0

# Example
print(min_subarray_length(7, [2, 3, 1, 2, 4, 3]))      # Output: 2 ([4, 3])
print(min_subarray_length(4, [1, 4, 4]))               # Output: 1 ([4])
print(min_subarray_length(15, [1, 4, 4]))              # Output: 0
```

---

## Monotonic Window Approach

### Overview
Uses a **monotonic deque** to efficiently track maximum/minimum elements in each sliding window. Particularly useful for finding max/min in all windows.

### Example 1: Maximum in Sliding Window (Using Deque)

```python
from collections import deque

def max_in_sliding_window(arr, k):
    """
    Find maximum element in each sliding window of size k
    
    Time Complexity: O(n)
    Space Complexity: O(k)
    """
    if not arr or k == 0:
        return []
    
    # Deque stores indices, not values
    dq = deque()
    result = []
    
    for i in range(len(arr)):
        # Remove indices outside current window
        while dq and dq[0] < i - k + 1:
            dq.popleft()
        
        # Remove indices with smaller values (monotonic decreasing)
        while dq and arr[dq[-1]] < arr[i]:
            dq.pop()
        
        # Add current index
        dq.append(i)
        
        # Once we have k elements, add max to result
        if i >= k - 1:
            result.append(arr[dq[0]])
    
    return result

# Example
print(max_in_sliding_window([1, 3, 1, 2, 0, 5], 3))  # Output: [3, 3, 2, 5]
print(max_in_sliding_window([1], 1))                  # Output: [1]
print(max_in_sliding_window([9, 11], 2))              # Output: [11]
```

### Example 2: Minimum in Sliding Window

```python
def min_in_sliding_window(arr, k):
    """
    Find minimum element in each sliding window of size k
    
    Time Complexity: O(n)
    Space Complexity: O(k)
    """
    if not arr or k == 0:
        return []
    
    dq = deque()
    result = []
    
    for i in range(len(arr)):
        # Remove indices outside current window
        while dq and dq[0] < i - k + 1:
            dq.popleft()
        
        # Remove indices with larger values (monotonic increasing)
        while dq and arr[dq[-1]] > arr[i]:
            dq.pop()
        
        dq.append(i)
        
        if i >= k - 1:
            result.append(arr[dq[0]])
    
    return result

# Example
print(min_in_sliding_window([1, 3, 1, 2, 0, 5], 3))  # Output: [1, 1, 0, 0]
```

### Example 3: Monotonic Queue for Tracking Elements

```python
def next_greater_elements_in_window(arr, k):
    """
    For each window, track elements in decreasing order of value
    
    Time Complexity: O(n)
    Space Complexity: O(k)
    """
    dq = deque()
    result = []
    
    for i in range(len(arr)):
        # Remove elements outside window
        while dq and dq[0][1] < i - k + 1:
            dq.popleft()
        
        # Remove smaller elements
        while dq and dq[-1][0] < arr[i]:
            dq.pop()
        
        dq.append((arr[i], i))
        
        if i >= k - 1:
            result.append([val for val, _ in dq])
    
    return result

# Example
print(next_greater_elements_in_window([1, 3, 1, 2, 0, 5], 3))
# Output: [[3, 1], [3, 2], [2, 0], [5]]
```

---

## Key Concepts

### 1. Two-Pointer Technique
The sliding window typically uses two pointers (left and right) to define the window boundaries.

```python
# Generic two-pointer template
left = 0
for right in range(len(arr)):
    # Expand window
    # Update state based on arr[right]
    
    # Shrink window if needed
    while not_valid():
        # Update state based on arr[left]
        left += 1
    
    # Process current window [left, right]
```

### 2. Window State Maintenance
Keep track of:
- Character frequencies
- Sum/Product
- Count of elements satisfying condition
- Min/Max in window

### 3. Optimization Tricks
- Use **hash maps** for O(1) lookups
- Use **deques** for efficient min/max queries
- Maintain **running sums** instead of recalculating
- Use **frequency arrays** for fixed character sets

---

## Common Patterns

| Problem Type | Approach | Example |
|---|---|---|
| **Longest/Shortest substring** | Variable window, expand-contract | Longest substring without repeating |
| **Max/Min in fixed window** | Fixed window, simple iteration OR Monotonic deque | Maximum in sliding window |
| **Substring containing all chars** | Variable window with frequency map | Minimum window substring |
| **Count subarrays with property** | Fixed window, iterate all positions | Subarrays with sum >= k |
| **Anagram/Permutation** | Variable window, frequency map | Permutation in string |
| **Subarray sum problems** | Variable window for prefix sums | Longest subarray with sum k |

---

## Detailed Problems & Solutions

### Problem 1: Fruit Into Baskets

```python
def total_fruit(tree):
    """
    You have two baskets of unlimited size. Pick fruits such that
    each basket contains only one type of fruit. Maximize the total fruits.
    This is essentially longest subarray with at most 2 distinct elements.
    
    Time Complexity: O(n)
    Space Complexity: O(1) - at most 2 fruits
    """
    left = 0
    fruit_count = {}
    max_fruits = 0
    
    for right in range(len(tree)):
        fruit = tree[right]
        fruit_count[fruit] = fruit_count.get(fruit, 0) + 1
        
        # If more than 2 types of fruits, shrink window
        while len(fruit_count) > 2:
            left_fruit = tree[left]
            fruit_count[left_fruit] -= 1
            if fruit_count[left_fruit] == 0:
                del fruit_count[left_fruit]
            left += 1
        
        max_fruits = max(max_fruits, right - left + 1)
    
    return max_fruits

# Example
print(total_fruit([1, 2, 1]))           # Output: 3
print(total_fruit([0, 1, 2, 2]))        # Output: 3
print(total_fruit([1, 2, 3, 2, 2]))     # Output: 4
```

### Problem 2: Permutation in String

```python
def check_permutation_in_string(s1, s2):
    """
    Check if s1 is a permutation that appears as substring in s2
    
    Time Complexity: O(n + m)
    Space Complexity: O(1) - at most 26 characters
    """
    if len(s1) > len(s2):
        return False
    
    s1_count = {}
    window_count = {}
    
    # Build frequency map for s1
    for char in s1:
        s1_count[char] = s1_count.get(char, 0) + 1
    
    left = 0
    matches = 0
    required = len(s1_count)
    
    for right in range(len(s2)):
        char = s2[right]
        window_count[char] = window_count.get(char, 0) + 1
        
        # If frequency of current char matches s1
        if char in s1_count and window_count[char] == s1_count[char]:
            matches += 1
        
        # Shrink window if larger than s1
        if right - left + 1 > len(s1):
            left_char = s2[left]
            if left_char in s1_count and window_count[left_char] == s1_count[left_char]:
                matches -= 1
            window_count[left_char] -= 1
            left += 1
        
        # If all characters match
        if matches == required:
            return True
    
    return False

# Example
print(check_permutation_in_string("ab", "eidbaooo"))     # Output: True
print(check_permutation_in_string("ab", "eidboaa"))      # Output: False
```

### Problem 3: Longest Repeating Character Replacement

```python
def character_replacement(s, k):
    """
    Find length of longest substring with at most k character replacements
    to make all characters the same.
    
    Time Complexity: O(n)
    Space Complexity: O(1) - at most 26 characters
    """
    char_count = {}
    left = 0
    max_length = 0
    
    for right in range(len(s)):
        # Add right character
        char = s[right]
        char_count[char] = char_count.get(char, 0) + 1
        
        # Get most frequent character count
        max_freq = max(char_count.values())
        
        # If characters we need to replace > k, shrink window
        if right - left + 1 - max_freq > k:
            left_char = s[left]
            char_count[left_char] -= 1
            left += 1
        
        max_length = max(max_length, right - left + 1)
    
    return max_length

# Example
print(character_replacement("ABAB", 2))      # Output: 4
print(character_replacement("ABBB", 2))      # Output: 4
print(character_replacement("AAAB", 0))      # Output: 3
```

---

## Time & Space Complexity Analysis

### Fixed Window Pattern
| Operation | Complexity | Notes |
|---|---|---|
| Window setup | O(k) | Calculate initial window |
| Sliding | O(n) | Visit each element once |
| **Total** | **O(n + k)** | k usually negligible |

### Variable Window Pattern
| Operation | Complexity | Notes |
|---|---|---|
| Two-pointer scan | O(n) | Each pointer moves at most n |
| Hash map ops | O(1) | Insert, delete, update |
| **Total** | **O(n)** | Linear time with small constant |

### Monotonic Deque Pattern
| Operation | Complexity | Notes |
|---|---|---|
| Deque operations | O(1) amortized | Each element added/removed once |
| Window iteration | O(n) | Process each element once |
| **Total** | **O(n)** | Linear time |

### Space Complexity Summary
- **Fixed Window**: O(1) - only maintain counters
- **Variable Window**: O(min(n, alphabet_size)) - hash map for frequencies
- **Monotonic Deque**: O(k) - deque stores at most k elements

---

## Best Practices

1. **Identify the window type**: Fixed vs Variable
2. **Define window validity**: What makes a window valid?
3. **Maintain window state**: Update incrementally, not from scratch
4. **Choose data structures wisely**: HashMap, Deque, Set based on needs
5. **Handle edge cases**: Empty input, single element, k > n
6. **Optimize space**: Use frequency arrays for fixed charset
7. **Test thoroughly**: Boundary conditions, empty windows

---

## Common Mistakes to Avoid

❌ **Recalculating from scratch**: Defeats the purpose of sliding window
❌ **Not handling window boundaries**: Off-by-one errors
❌ **Forgetting to shrink window**: Can lead to invalid windows
❌ **Wrong data structure**: Hash map vs Deque vs Array
❌ **Not considering duplicates**: Frequency tracking is crucial
❌ **Memory leaks**: Not removing elements from hash map when count is 0

---

## Summary

The **Sliding Window** pattern is powerful for:
- ✅ Linear time solutions to problems that seem O(n²)
- ✅ Optimization of problems involving contiguous subarrays
- ✅ Handling frequency/count problems efficiently

**Key insight**: Instead of recalculating for each position, maintain the calculation and update it as the window moves.
