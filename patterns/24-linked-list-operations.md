# Pattern 24: Linked List Operations

## Overview
Common linked list patterns including reversal, merging, cycle detection.

## Node Definition
```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
```

## Key Operations

### Reverse Linked List (LeetCode 206)
```python
def reverseList(head):
    prev = None
    current = head
    
    while current:
        next_node = current.next
        current.next = prev
        prev = current
        current = next_node
    
    return prev
```

### Merge Two Sorted Lists (LeetCode 21)
```python
def mergeTwoLists(l1, l2):
    dummy = ListNode(0)
    current = dummy
    
    while l1 and l2:
        if l1.val < l2.val:
            current.next = l1
            l1 = l1.next
        else:
            current.next = l2
            l2 = l2.next
        current = current.next
    
    current.next = l1 or l2
    return dummy.next
```

### Remove Nth Node From End (LeetCode 19)
```python
def removeNthFromEnd(head, n):
    dummy = ListNode(0, head)
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

### Linked List Cycle Detection (LeetCode 141)
```python
def hasCycle(head):
    slow = fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        if slow == fast:
            return True
    
    return False
```

## Summary
- **Two pointers**: Fast/slow for cycles, middle
- **Dummy node**: Simplifies edge cases
- **Complexity**: Usually O(n) time, O(1) space
"""
