# Pattern 4: Fast & Slow Pointers (Floyd's Cycle Detection)

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

The Fast & Slow Pointers pattern (also known as the Tortoise and Hare algorithm) uses two pointers moving at different speeds to solve problems efficiently. This pattern is particularly useful for:

- Detecting cycles in linked lists
- Finding the middle element
- Detecting palindromes
- Finding the start of a cycle
- Removing duplicates

**Key Advantage**: Solves problems in O(n) time with O(1) space by using two pointers instead of hash sets.

## Pattern Variations

### 1. **Cycle Detection**
- Fast moves 2 steps, slow moves 1 step
- **Time**: O(n), **Space**: O(1)
- **Best for**: Detecting cycles in linked lists

### 2. **Finding Middle**
- When fast reaches end, slow is at middle
- **Time**: O(n), **Space**: O(1)
- **Best for**: Finding middle element

### 3. **Finding Nth from End**
- Move fast n steps ahead, then move both
- **Time**: O(n), **Space**: O(1)
- **Best for**: Accessing elements from end

---

## Core Concepts

### When to Use Fast & Slow Pointers?

✓ **Use when:**
- Working with linked lists or sequences
- Need to detect cycles
- Need to find middle or nth element
- Space must be O(1)
- Problem involves "meeting point" concept

✗ **Don't use when:**
- Need random access (use array indexing)
- Working with disconnected data
- Hash set approach is simpler and acceptable

### Why It Works

The fast and slow pointers work because:
1. **Different speeds**: Fast catches up to slow if there's a cycle
2. **Meeting point**: Mathematical guarantee of meeting in cycle
3. **Distance relationships**: Predictable position relationships

---

## Detailed Implementations

### Pattern 1: Linked List Cycle Detection

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def hasCycle(head):
    """
    LeetCode 141: Linked List Cycle
    
    Detect if linked list has a cycle.
    
    Args:
        head: Head of linked list
    
    Returns:
        True if cycle exists, False otherwise
    
    Time: O(n), Space: O(1)
    """
    if not head or not head.next:
        return False
    
    slow = head
    fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        
        if slow == fast:
            return True
    
    return False

# Why it works: If there's a cycle, fast will eventually catch slow
# In worst case, fast does at most 2n steps
```

### Pattern 2: Find Cycle Start

```python
def detectCycle(head):
    """
    LeetCode 142: Linked List Cycle II
    
    Find the node where the cycle begins.
    
    Args:
        head: Head of linked list
    
    Returns:
        Node where cycle starts, or None
    
    Time: O(n), Space: O(1)
    """
    if not head or not head.next:
        return None
    
    # Phase 1: Detect cycle
    slow = fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        
        if slow == fast:
            break
    else:
        return None  # No cycle
    
    # Phase 2: Find cycle start
    # Distance from head to cycle start == 
    # Distance from meeting point to cycle start
    slow = head
    while slow != fast:
        slow = slow.next
        fast = fast.next
    
    return slow

# Mathematical proof:
# Let: L = distance from head to cycle start
#      C = cycle length
#      k = distance from cycle start to meeting point
# 
# When they meet:
# Slow traveled: L + k
# Fast traveled: L + k + nC (n complete cycles)
# 
# Since fast is twice as fast: 2(L + k) = L + k + nC
# Simplify: L + k = nC
# Therefore: L = nC - k
```

### Pattern 3: Find Middle of Linked List

```python
def middleNode(head):
    """
    LeetCode 876: Middle of the Linked List
    
    Find middle node of linked list.
    If two middle nodes, return second one.
    
    Args:
        head: Head of linked list
    
    Returns:
        Middle node
    
    Time: O(n), Space: O(1)
    """
    slow = fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
    
    return slow

# When fast reaches end, slow is at middle
# For odd length: slow is exactly at middle
# For even length: slow is at second middle node
```

### Pattern 4: Palindrome Linked List

```python
def isPalindrome(head):
    """
    LeetCode 234: Palindrome Linked List
    
    Check if linked list is palindrome.
    
    Args:
        head: Head of linked list
    
    Returns:
        True if palindrome, False otherwise
    
    Time: O(n), Space: O(1)
    """
    if not head or not head.next:
        return True
    
    # Find middle
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
    
    # Reverse second half
    def reverse(node):
        prev = None
        while node:
            next_node = node.next
            node.next = prev
            prev = node
            node = next_node
        return prev
    
    second_half = reverse(slow)
    
    # Compare both halves
    first_half = head
    while second_half:
        if first_half.val != second_half.val:
            return False
        first_half = first_half.next
        second_half = second_half.next
    
    return True
```

### Pattern 5: Remove Nth Node From End

```python
def removeNthFromEnd(head, n):
    """
    LeetCode 19: Remove Nth Node From End of List
    
    Remove nth node from end of list.
    
    Args:
        head: Head of linked list
        n: Position from end (1-indexed)
    
    Returns:
        Head of modified list
    
    Time: O(L), Space: O(1) where L is list length
    """
    dummy = ListNode(0)
    dummy.next = head
    
    fast = slow = dummy
    
    # Move fast n+1 steps ahead
    for _ in range(n + 1):
        fast = fast.next
    
    # Move both until fast reaches end
    while fast:
        fast = fast.next
        slow = slow.next
    
    # Remove nth node
    slow.next = slow.next.next
    
    return dummy.next
```

### Pattern 6: Happy Number

```python
def isHappy(n):
    """
    LeetCode 202: Happy Number
    
    A happy number eventually reaches 1 when replaced
    by sum of squares of digits. Detect cycle with fast/slow.
    
    Args:
        n: Positive integer
    
    Returns:
        True if happy number
    
    Time: O(log n), Space: O(1)
    """
    def get_next(num):
        total = 0
        while num > 0:
            digit = num % 10
            total += digit * digit
            num //= 10
        return total
    
    slow = n
    fast = get_next(n)
    
    while fast != 1 and slow != fast:
        slow = get_next(slow)
        fast = get_next(get_next(fast))
    
    return fast == 1

# Test cases
print(isHappy(19))  # True (19 → 82 → 68 → 100 → 1)
print(isHappy(2))   # False (enters cycle)
```

### Pattern 7: Reorder List

```python
def reorderList(head):
    """
    LeetCode 143: Reorder List
    
    Reorder L0 → L1 → L2 → ... → Ln-1 → Ln to:
    L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → ...
    
    Args:
        head: Head of linked list
    
    Returns:
        None (modify in-place)
    
    Time: O(n), Space: O(1)
    """
    if not head or not head.next:
        return
    
    # Find middle
    slow = fast = head
    while fast.next and fast.next.next:
        slow = slow.next
        fast = fast.next.next
    
    # Reverse second half
    second = slow.next
    slow.next = None
    
    prev = None
    while second:
        next_node = second.next
        second.next = prev
        prev = second
        second = next_node
    second = prev
    
    # Merge two halves
    first = head
    while second:
        next1 = first.next
        next2 = second.next
        
        first.next = second
        second.next = next1
        
        first = next1
        second = next2
```

---

## Complexity Analysis

### Time Complexity

| Pattern | Time | Explanation |
|---------|------|-------------|
| Cycle Detection | O(n) | Fast meets slow within 2n steps |
| Find Middle | O(n) | One pass through list |
| Nth from End | O(n) | Two pointers, one pass |
| Palindrome Check | O(n) | Find middle + reverse + compare |

### Space Complexity

All patterns use **O(1) space** - only a few pointers regardless of input size.

### Why O(n) for Cycle Detection?

- Worst case: Fast does ≤ 2n steps to catch slow
- In cycle of length C, fast gains 1 position per step
- Will meet within C steps after entering cycle

---

## Example Problems

### Problem 1: Intersection of Two Linked Lists (LeetCode 160)

```python
def getIntersectionNode(headA, headB):
    """
    Find node where two linked lists intersect.
    
    Time: O(m + n), Space: O(1)
    """
    if not headA or not headB:
        return None
    
    pA, pB = headA, headB
    
    # When one reaches end, switch to other list's head
    # They will meet at intersection or both reach None
    while pA != pB:
        pA = pA.next if pA else headB
        pB = pB.next if pB else headA
    
    return pA

# Why it works: After switching, both traverse same total distance
# Distance: lenA + common + lenB == lenB + common + lenA
```

### Problem 2: Find Duplicate Number (LeetCode 287)

```python
def findDuplicate(nums):
    """
    Find duplicate in array where each integer is 1 to n.
    Treat as linked list: nums[i] is "next" pointer.
    
    Time: O(n), Space: O(1)
    """
    # Phase 1: Find meeting point
    slow = fast = nums[0]
    
    while True:
        slow = nums[slow]
        fast = nums[nums[fast]]
        if slow == fast:
            break
    
    # Phase 2: Find entrance (duplicate)
    slow = nums[0]
    while slow != fast:
        slow = nums[slow]
        fast = nums[fast]
    
    return slow

# Test cases
print(findDuplicate([1, 3, 4, 2, 2]))  # 2
print(findDuplicate([3, 1, 3, 4, 2]))  # 3
```

### Problem 3: Circular Array Loop (LeetCode 457)

```python
def circularArrayLoop(nums):
    """
    Check if there's a loop in circular array where
    next index is current + nums[current].
    
    Time: O(n), Space: O(1)
    """
    def get_next(index):
        n = len(nums)
        return (index + nums[index]) % n
    
    def is_valid_cycle(start):
        direction = nums[start] > 0
        slow = fast = start
        
        while True:
            # Move slow one step
            slow = get_next(slow)
            if nums[slow] * nums[start] <= 0:
                return False  # Direction changed
            if slow == get_next(slow):
                return False  # Self loop
            
            # Move fast two steps
            fast = get_next(fast)
            if nums[fast] * nums[start] <= 0:
                return False
            if fast == get_next(fast):
                return False
            
            fast = get_next(fast)
            if nums[fast] * nums[start] <= 0:
                return False
            
            if slow == fast:
                return True
    
    for i in range(len(nums)):
        if is_valid_cycle(i):
            return True
    
    return False
```

---

## Use Cases and Best Practices

### Best Use Cases

1. **Linked List Problems**
   - Cycle detection
   - Finding middle
   - Removing nodes

2. **Array as Linked List**
   - Index jumping problems
   - Duplicate finding

3. **Sequence Problems**
   - Happy numbers
   - Cyclic sequences

### Best Practices

✓ **Do's**
- Initialize both pointers properly
- Check for null/empty cases first
- Use dummy node for head modifications
- Understand the mathematical relationships
- Draw diagrams for complex movements

✗ **Don'ts**
- Don't forget to check fast.next before fast.next.next
- Don't confuse when to move pointers
- Don't forget edge cases (empty list, single node)
- Don't use when hash set is simpler
- Don't modify original structure unless allowed

---

## Common Pitfalls

### Pitfall 1: Not Checking fast.next

```python
# ❌ WRONG: Null pointer exception
while fast:
    fast = fast.next.next  # Crashes if fast.next is None!

# ✓ CORRECT: Check both conditions
while fast and fast.next:
    fast = fast.next.next
```

### Pitfall 2: Wrong Initialization

```python
# ❌ WRONG: Pointers start same, immediately equal
slow = fast = head
if slow == fast:  # Always true!
    return True

# ✓ CORRECT: Move before checking
slow = fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
    if slow == fast:  # Check after moving
        return True
```

### Pitfall 3: Off-by-One in Nth from End

```python
# ❌ WRONG: Fast is only n steps ahead
for i in range(n):
    fast = fast.next
# Now slow.next is (n+1)th from end, not nth!

# ✓ CORRECT: Fast is n+1 steps ahead
for i in range(n + 1):
    fast = fast.next
# Now slow.next is nth from end
```

### Pitfall 4: Modifying Without Dummy Node

```python
# ❌ WRONG: Doesn't handle removing head
def removeFirst(head):
    head = head.next  # Doesn't actually remove!
    return head

# ✓ CORRECT: Use dummy node
def removeFirst(head):
    dummy = ListNode(0)
    dummy.next = head
    dummy.next = head.next
    return dummy.next
```

---

## Interview Tips

### How to Approach in Interview

1. **Identify Pattern**
   - Does problem involve cycles or sequences?
   - Need middle element or nth from end?
   - Space constraint suggests two pointers?

2. **Choose Speed Difference**
   - Usually 2x speed (fast moves 2, slow moves 1)
   - Sometimes 1-step offset (for nth from end)

3. **Explain the Math**
   - "Fast moves twice as fast, so it covers 2n distance..."
   - "When fast reaches end, slow is at middle because..."
   - "They meet in cycle because fast gains on slow..."

4. **Handle Edge Cases**
   - Empty list
   - Single node
   - No cycle
   - List with 2 nodes

5. **State Complexity**
   - "Time O(n) because each node visited at most twice"
   - "Space O(1) because we only use two pointers"

### What Interviewers Look For

✓ Understanding of why algorithm works
✓ Proper null checking
✓ Correct pointer initialization and movement
✓ Edge case handling
✓ Space optimization awareness
✓ Clear explanation of meeting point concept

### Follow-up Questions to Prepare For

- "What if fast moves 3x as fast?"
- "How do you find the length of the cycle?"
- "Can you solve without modifying the list?"
- "What's the space complexity of hash set approach?"
- "How does this compare to using recursion?"

---

## Summary

| Aspect | Details |
|--------|---------|
| **When to use** | Cycles, middle finding, linked lists |
| **Main advantage** | O(1) space, efficient cycle detection |
| **Main patterns** | 2x speed, n-step offset, meeting point |
| **Time complexity** | O(n) typically |
| **Space complexity** | O(1) - constant pointers |
| **Difficulty** | Medium (understanding the math) |

---

## References and Resources

- Floyd's Cycle Detection Algorithm
- LeetCode Tag: Two Pointers
- "Floyd's Tortoise and Hare" algorithm explanation
- Mathematical proof of meeting point

**Related Patterns:**
- Two Pointers (general technique)
- Linked List Traversal
- Cycle Detection in Graphs
