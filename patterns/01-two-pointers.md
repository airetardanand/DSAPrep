# Pattern 1: Two Pointers

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

The Two Pointers pattern is a fundamental algorithmic technique that uses two references (pointers) to traverse data structures, typically arrays or linked lists. This pattern is particularly useful for problems involving:

- Finding pairs or triplets with specific properties
- Removing duplicates or invalid elements
- Partitioning arrays
- Detecting cycles in linked lists

**Key Advantage**: Reduces time complexity from O(n²) to O(n) or O(n log n) by eliminating the need for nested loops.

## Pattern Variations

### 1. **Converging Pointers** (Most Common)
- Start with pointers at opposite ends
- Move them towards each other based on conditions
- **Best for**: Finding pairs, containers, partitioning

### 2. **Fast/Slow Pointers**
- One pointer moves faster than the other
- Often moves by 2 while other moves by 1
- **Best for**: Cycle detection, finding middle element, removing duplicates

### 3. **In-place Operations**
- Manipulate array elements while traversing
- Useful for modifying input without extra space
- **Best for**: Removing elements, partitioning, in-place sorting

---

## Core Concepts

### When to Use Two Pointers?

✓ **Use when:**
- Array/list is sorted or can be sorted
- Need to find pairs/triplets with specific sum or property
- Need to partition the array
- Working with linked list operations
- Space optimization is critical

✗ **Don't use when:**
- Random access to elements is needed
- Modifying array size frequently
- Problem requires nested iterations beyond two levels

### Why It Works

The two pointers technique works because:
1. **Sorted property preservation**: In sorted arrays, we can eliminate possibilities
2. **Bidirectional elimination**: Both ends are processed simultaneously
3. **Time optimization**: Avoid checking unnecessary combinations

---

## Detailed Implementations

### Pattern 1: Converging Pointers (Classic)

```python
def two_pointers_converging(arr, target):
    """
    Find if two numbers sum to target.
    Assumes: arr is sorted
    Time: O(n), Space: O(1)
    """
    left = 0
    right = len(arr) - 1
    
    while left < right:
        current_sum = arr[left] + arr[right]
        
        if current_sum == target:
            return [arr[left], arr[right]]
        elif current_sum < target:
            # Need larger sum, move left pointer right
            left += 1
        else:
            # Need smaller sum, move right pointer left
            right -= 1
    
    return None
```

**When to move which pointer:**
- If sum is too small → move `left` pointer RIGHT (increase sum)
- If sum is too large → move `right` pointer LEFT (decrease sum)

### Pattern 2: Fast/Slow Pointers

```python
def fast_slow_remove_duplicates(arr):
    """
    Remove duplicates in-place and return new length.
    Time: O(n), Space: O(1)
    """
    if len(arr) <= 1:
        return len(arr)
    
    slow = 1  # Points to position to fill
    fast = 1  # Points to element being checked
    
    while fast < len(arr):
        # Only move slow forward when we find a new unique element
        if arr[fast] != arr[fast - 1]:
            arr[slow] = arr[fast]
            slow += 1
        fast += 1
    
    return slow
```

**Key Insight**: `slow` pointer marks the boundary of valid elements, while `fast` pointer explores.

### Pattern 3: Cycle Detection in Linked List (Floyd's Algorithm)

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def detect_cycle(head):
    """
    Detect if linked list has a cycle.
    Time: O(n), Space: O(1)
    """
    if not head or not head.next:
        return False
    
    slow = head
    fast = head.next
    
    while fast and fast.next:
        if slow == fast:
            return True
        slow = slow.next
        fast = fast.next.next
    
    return False
```

**Why it works**: If there's a cycle, fast pointer will eventually catch up to slow pointer.

### Pattern 4: In-place Partition (Dutch National Flag Problem)

```python
def partition_array(arr, pivot):
    """
    Partition array so elements < pivot on left, >= pivot on right.
    Time: O(n), Space: O(1)
    """
    left = 0
    right = len(arr) - 1
    
    while left <= right:
        # Move left until we find element >= pivot
        while left <= right and arr[left] < pivot:
            left += 1
        
        # Move right until we find element < pivot
        while left <= right and arr[right] >= pivot:
            right -= 1
        
        # Swap if pointers haven't crossed
        if left < right:
            arr[left], arr[right] = arr[right], arr[left]
            left += 1
            right -= 1
    
    return left  # Return partition point
```

### Pattern 5: Reverse Array/String In-place

```python
def reverse_inplace(arr):
    """
    Reverse array in-place using two pointers.
    Time: O(n), Space: O(1)
    """
    left = 0
    right = len(arr) - 1
    
    while left < right:
        arr[left], arr[right] = arr[right], arr[left]
        left += 1
        right -= 1
    
    return arr
```

---

## Complexity Analysis

### Time Complexity

| Pattern | Time | Space | Notes |
|---------|------|-------|-------|
| Converging | O(n) | O(1) | Single pass, two pointers |
| Fast/Slow | O(n) | O(1) | Single pass, constant space |
| Partitioning | O(n) | O(1) | Single pass with swaps |
| Cycle Detection | O(n) | O(1) | At most 2n iterations |

### Space Complexity Analysis

**O(1) Space Advantage:**
- No hash maps or sets needed
- No recursion stack
- No extra arrays
- Only a few pointer variables

**Trade-off:** Often requires pre-sorting (O(n log n)) or array must already be sorted.

---

## Example Problems

### Problem 1: Two Sum II (Sorted Array)

**Problem**: Given a sorted array and a target, find two numbers that add up to target.

```python
def twoSum(numbers, target):
    """
    LeetCode 167: Two Sum II - Input Array is Sorted
    
    Args:
        numbers: Sorted array of integers
        target: Target sum
    
    Returns:
        List of 1-indexed positions [index1, index2]
    
    Example:
        Input: numbers = [2,7,11,15], target = 9
        Output: [1, 2]
    """
    left = 0
    right = len(numbers) - 1
    
    while left < right:
        current_sum = numbers[left] + numbers[right]
        
        if current_sum == target:
            return [left + 1, right + 1]  # 1-indexed
        elif current_sum < target:
            left += 1
        else:
            right -= 1
    
    return []

# Test cases
print(twoSum([2, 7, 11, 15], 9))      # [1, 2]
print(twoSum([2, 3, 4], 6))           # [1, 3]
print(twoSum([-1, 0], -1))            # [1, 2]
```

### Problem 2: Remove Duplicates from Sorted Array

**Problem**: Remove duplicates from sorted array in-place. Return the length of unique elements.

```python
def removeDuplicates(nums):
    """
    LeetCode 26: Remove Duplicates from Sorted Array
    
    Args:
        nums: Sorted array with possible duplicates
    
    Returns:
        Length of array after removing duplicates
    
    Example:
        Input: nums = [1,1,2]
        Output: 2, nums = [1,2,_]
    """
    if len(nums) <= 1:
        return len(nums)
    
    slow = 1
    
    for fast in range(1, len(nums)):
        if nums[fast] != nums[fast - 1]:
            nums[slow] = nums[fast]
            slow += 1
    
    return slow

# Test cases
nums1 = [1, 1, 2]
print(removeDuplicates(nums1))        # 2, nums1 = [1, 2, _]

nums2 = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
print(removeDuplicates(nums2))        # 5, nums2 = [0, 1, 2, 3, 4, ...]
```

### Problem 3: Container With Most Water

**Problem**: Find two lines that form a container with maximum area.

```python
def maxArea(height):
    """
    LeetCode 11: Container With Most Water
    
    Args:
        height: List of integers representing heights
    
    Returns:
        Maximum area that can be contained
    
    Example:
        Input: height = [1,8,6,2,5,4,8,3,7]
        Output: 49
        Explanation: Line at index 1 and 8 gives area = 7 * 8 = 56... 
                     Actually indices 1,8 give 7*7=49
    """
    max_area = 0
    left = 0
    right = len(height) - 1
    
    while left < right:
        # Area = width * min(height)
        width = right - left
        current_height = min(height[left], height[right])
        area = width * current_height
        max_area = max(max_area, area)
        
        # Move the pointer with smaller height (potential for improvement)
        if height[left] < height[right]:
            left += 1
        else:
            right -= 1
    
    return max_area

# Test cases
print(maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]))  # 49
print(maxArea([1, 1]))                        # 1
print(maxArea([4, 3, 2, 1, 4]))             # 16
```

**Why move shorter height pointer?**
- Moving the taller one can only reduce area (width decreases, height limited by shorter line)
- Moving the shorter one has potential to find taller line (might increase area)

### Problem 4: Valid Palindrome

**Problem**: Check if string is valid palindrome (alphanumeric only, case-insensitive).

```python
def isPalindrome(s):
    """
    LeetCode 125: Valid Palindrome
    
    Args:
        s: String to check
    
    Returns:
        True if valid palindrome, False otherwise
    
    Example:
        Input: s = "A man, a plan, a canal: Panama"
        Output: True
    """
    left = 0
    right = len(s) - 1
    
    while left < right:
        # Skip non-alphanumeric characters from left
        while left < right and not s[left].isalnum():
            left += 1
        
        # Skip non-alphanumeric characters from right
        while left < right and not s[right].isalnum():
            right -= 1
        
        # Compare characters (case-insensitive)
        if s[left].lower() != s[right].lower():
            return False
        
        left += 1
        right -= 1
    
    return True

# Test cases
print(isPalindrome("A man, a plan, a canal: Panama"))  # True
print(isPalindrome("race a car"))                       # False
print(isPalindrome(" "))                                # True
print(isPalindrome("0P"))                              # False
```

### Problem 5: Remove Duplicates II (At Most 2 Occurrences)

**Problem**: Allow each unique number to appear at most twice.

```python
def removeDuplicatesII(nums):
    """
    LeetCode 80: Remove Duplicates from Sorted Array II
    Allow each number to appear at most k=2 times
    
    Args:
        nums: Sorted array
    
    Returns:
        Length of valid array
    
    Example:
        Input: nums = [1,1,1,2,2,3]
        Output: 5, nums = [1,1,2,2,3,_]
    """
    slow = 0
    
    for fast in range(len(nums)):
        # Allow element if it's first two occurrences
        if fast < 2 or nums[fast] != nums[slow - 2]:
            nums[slow] = nums[fast]
            slow += 1
    
    return slow

# Test cases
nums1 = [1, 1, 1, 2, 2, 3]
print(removeDuplicatesII(nums1))      # 5, nums1 = [1, 1, 2, 2, 3, _]

nums2 = [0, 0, 1, 1, 1, 1, 2, 3, 3]
print(removeDuplicatesII(nums2))      # 7
```

**Key Insight**: Compare with `nums[slow - 2]` to ensure at most 2 occurrences.

### Problem 6: Sort Array By Parity

**Problem**: Arrange array so all even numbers come before odd numbers.

```python
def sortArrayByParity(nums):
    """
    LeetCode 905: Sort Array By Parity
    
    Args:
        nums: Array of integers
    
    Returns:
        Array with even numbers first
    
    Example:
        Input: nums = [3,1,2,4]
        Output: [2,4,3,1] or [4,2,3,1]
    """
    left = 0
    right = len(nums) - 1
    
    while left < right:
        # Find odd number from left
        while left < right and nums[left] % 2 == 0:
            left += 1
        
        # Find even number from right
        while left < right and nums[right] % 2 == 1:
            right -= 1
        
        # Swap odd with even
        if left < right:
            nums[left], nums[right] = nums[right], nums[left]
            left += 1
            right -= 1
    
    return nums

# Test cases
print(sortArrayByParity([3, 1, 2, 4]))      # [2, 4, 3, 1] or [4, 2, 1, 3]
print(sortArrayByParity([0]))               # [0]
print(sortArrayByParity([1]))               # [1]
```

### Problem 7: Linked List Cycle II

**Problem**: Find the start of cycle in linked list (return null if no cycle).

```python
def detectCycleStart(head):
    """
    LeetCode 142: Linked List Cycle II
    Find the node where cycle begins
    
    Args:
        head: Head of linked list
    
    Returns:
        Node where cycle starts, or None if no cycle
    """
    if not head or not head.next:
        return None
    
    # Phase 1: Detect cycle using Floyd's algorithm
    slow = head
    fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        
        if slow == fast:
            # Cycle detected
            break
    else:
        # No cycle
        return None
    
    # Phase 2: Find cycle start
    # Distance from head to cycle start = 
    # Distance from meeting point to cycle start
    ptr1 = head
    ptr2 = slow
    
    while ptr1 != ptr2:
        ptr1 = ptr1.next
        ptr2 = ptr2.next
    
    return ptr1

# Test case creation (can't easily show with cycle)
# Would create list: 3 -> 2 -> 0 -> -4 -> 2 (cycle back to index 1)
```

### Problem 8: 3Sum

**Problem**: Find all unique triplets that sum to zero.

```python
def threeSum(nums):
    """
    LeetCode 15: 3Sum
    Find all unique triplets that sum to 0
    
    Args:
        nums: Array of integers
    
    Returns:
        List of triplets
    
    Example:
        Input: nums = [-1,0,1,2,-1,-4]
        Output: [[-1,-1,2],[-1,0,1]]
    """
    nums.sort()
    result = []
    
    for i in range(len(nums) - 2):
        # Skip duplicates
        if i > 0 and nums[i] == nums[i - 1]:
            continue
        
        # If number is positive, no need to continue
        if nums[i] > 0:
            break
        
        # Use two pointers for remaining elements
        left = i + 1
        right = len(nums) - 1
        target = -nums[i]
        
        while left < right:
            current_sum = nums[left] + nums[right]
            
            if current_sum == target:
                result.append([nums[i], nums[left], nums[right]])
                
                # Skip duplicates for left
                while left < right and nums[left] == nums[left + 1]:
                    left += 1
                # Skip duplicates for right
                while left < right and nums[right] == nums[right - 1]:
                    right -= 1
                
                left += 1
                right -= 1
            elif current_sum < target:
                left += 1
            else:
                right -= 1
    
    return result

# Test cases
print(threeSum([-1, 0, 1, 2, -1, -4]))  # [[-1, -1, 2], [-1, 0, 1]]
print(threeSum([0, 0, 0, 0]))           # [[0, 0, 0]]
print(threeSum([-2, 0, 1, 1, 2]))       # [[-2, 0, 2], [-2, 1, 1]]
```

---

## Use Cases and Best Practices

### Best Use Cases

1. **Array Problems**
   - Two Sum variants
   - Container With Most Water
   - Trapping Rain Water
   - Sort colors (Dutch National Flag)

2. **String Problems**
   - Valid Palindrome
   - Reverse String
   - Merge Sorted Strings

3. **Linked List Problems**
   - Cycle detection (Floyd's Algorithm)
   - Find middle element
   - Remove nth node from end
   - Merge sorted lists

4. **Partitioning Problems**
   - Partition array
   - Quick select median finding
   - Sort specific items to sides

### Best Practices

✓ **Do's**
- Always verify if array needs sorting first
- Handle edge cases (empty arrays, single elements)
- Skip duplicates to avoid redundant comparisons
- Choose movement direction strategically
- Use meaningful variable names (`left`, `right`, `slow`, `fast`)

✗ **Don'ts**
- Don't assume array is sorted without confirmation
- Don't forget to update/move pointers
- Don't ignore integer overflow in languages that require it
- Don't use two pointers if hash-based approach is simpler
- Don't modify array if problem requires immutability

### Decision Tree

```
Problem involves finding/modifying in array?
├─ YES → Is array sorted? (or can be sorted?)
│        ├─ YES → Two Pointers ✓
│        └─ NO  → Sort first, then Two Pointers
├─ Need to find pairs/values with specific property?
│  └─ YES → Converging Pointers or Fast/Slow
├─ Need to remove elements in-place?
│  └─ YES → Fast/Slow or In-place modification
└─ Need cycle detection in linked list?
   └─ YES → Floyd's Fast/Slow Algorithm
```

---

## Common Pitfalls

### Pitfall 1: Not Moving Pointer When Should

```python
# ❌ WRONG: Infinite loop
while left < right:
    if arr[left] + arr[right] == target:
        return [arr[left], arr[right]]
    # Forgot to move pointers!

# ✓ CORRECT
while left < right:
    if arr[left] + arr[right] == target:
        return [arr[left], arr[right]]
    elif arr[left] + arr[right] < target:
        left += 1
    else:
        right -= 1
```

### Pitfall 2: Wrong Comparison Direction

```python
# ❌ WRONG: Moving wrong pointer for problem context
# For Two Sum, moving right when sum < target decreases sum further

# ✓ CORRECT: Always reason about effect of pointer movement
# Sum too small → need larger number → move left pointer right
# Sum too large → need smaller number → move right pointer left
```

### Pitfall 3: Not Handling Duplicates

```python
# ❌ WRONG: Reports same triplet multiple times
result = []
for i in range(len(nums)):
    # No duplicate checking

# ✓ CORRECT
for i in range(len(nums)):
    if i > 0 and nums[i] == nums[i - 1]:
        continue  # Skip duplicates
```

### Pitfall 4: Array Modification Side Effects

```python
# ❌ WRONG: Modifying array while iterating can cause issues
def removeDuplicates(nums):
    for i in range(len(nums)):
        if nums[i] == nums[i + 1]:
            del nums[i]  # Don't modify while iterating!

# ✓ CORRECT: Use separate pointers for read/write
def removeDuplicates(nums):
    slow = 1
    for fast in range(1, len(nums)):
        if nums[fast] != nums[fast - 1]:
            nums[slow] = nums[fast]
            slow += 1
    return slow
```

### Pitfall 5: Boundary Conditions

```python
# ❌ WRONG: Missing edge cases
while left < right:  # What if left == right?
    # Access nums[right + 1]  # Can cause index error!

# ✓ CORRECT: Think about boundaries
while left < right:
    if fast < len(nums):  # Check bounds
        # Safe access
```

---

## Interview Tips

### How to Explain in Interview

1. **Identify the pattern**: "This problem can be solved with two pointers..."
2. **Choose variation**: "...specifically, I'll use converging pointers because..."
3. **State assumptions**: "Assuming the array is sorted..."
4. **Walk through example**: "Let me trace through with example [2,7,11,15]..."
5. **State complexity**: "Time: O(n), Space: O(1)..."

### What Interviewers Look For

✓ Pattern recognition
✓ Understanding of why each approach works
✓ Proper pointer movement logic
✓ Edge case handling
✓ Clean, readable code
✓ Space optimization awareness

### Follow-up Questions to Prepare For

- "What if array is not sorted?"
- "Can you do it without modifying the input?"
- "What if there are duplicates?"
- "Can you find all pairs/triplets?"
- "How would you optimize further?"

---

## Summary

| Aspect | Details |
|--------|---------|
| **When to use** | Sorted arrays, pair finding, partitioning, linked lists |
| **Main advantage** | Linear time O(n) with O(1) space |
| **Main variations** | Converging, Fast/Slow, In-place |
| **Time complexity** | O(n) typically, O(n log n) if sorting needed |
| **Space complexity** | O(1) - using only pointers |
| **Difficulty** | Easy to Medium (understanding movement logic) |

---

## References and Resources

- LeetCode Tag: Two Pointers
- GeeksforGeeks: Two Pointer Technique
- Floyd's Cycle Detection Algorithm
- Dutch National Flag Problem

**Related Patterns:**
- Sliding Window (similar but window size varies)
- Binary Search (similar pointer movement concept)
- HashMap/Set (alternative for some problems)
