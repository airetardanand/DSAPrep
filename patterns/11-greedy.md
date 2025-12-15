# Pattern 11: Greedy Algorithms

## Overview

Greedy algorithms make locally optimal choices at each step, hoping to find a global optimum. They work when the problem has the **greedy choice property**: local optimum leads to global optimum.

## When to Use Greedy

✓ Problem has greedy choice property
✓ Optimal substructure exists
✓ Can prove correctness
✗ When counterexample exists

## Key Problems

### Problem 1: Jump Game (LeetCode 55)

```python
def canJump(nums):
    """
    Can reach last index?
    Each element is max jump length.
    
    Time: O(n), Space: O(1)
    """
    max_reach = 0
    
    for i in range(len(nums)):
        if i > max_reach:
            return False
        max_reach = max(max_reach, i + nums[i])
    
    return True

print(canJump([2,3,1,1,4]))  # True
print(canJump([3,2,1,0,4]))  # False
```

### Problem 2: Jump Game II (LeetCode 45)

```python
def jump(nums):
    """
    Minimum jumps to reach last index.
    
    Time: O(n), Space: O(1)
    """
    jumps = 0
    current_end = 0
    farthest = 0
    
    for i in range(len(nums) - 1):
        farthest = max(farthest, i + nums[i])
        
        if i == current_end:
            jumps += 1
            current_end = farthest
    
    return jumps

print(jump([2,3,1,1,4]))  # 2
```

### Problem 3: Activity Selection / Meeting Rooms

```python
def maxMeetings(intervals):
    """
    Maximum number of non-overlapping meetings.
    
    Time: O(n log n), Space: O(1)
    """
    if not intervals:
        return 0
    
    # Sort by end time (greedy choice)
    intervals.sort(key=lambda x: x[1])
    
    count = 1
    end_time = intervals[0][1]
    
    for start, end in intervals[1:]:
        if start >= end_time:
            count += 1
            end_time = end
    
    return count

print(maxMeetings([[1,3],[2,4],[3,5],[4,6]]))  # 3
```

### Problem 4: Gas Station (LeetCode 134)

```python
def canCompleteCircuit(gas, cost):
    """
    Find starting gas station to complete circuit.
    
    Time: O(n), Space: O(1)
    """
    total_tank = 0
    current_tank = 0
    start = 0
    
    for i in range(len(gas)):
        total_tank += gas[i] - cost[i]
        current_tank += gas[i] - cost[i]
        
        if current_tank < 0:
            start = i + 1
            current_tank = 0
    
    return start if total_tank >= 0 else -1

print(canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2]))  # 3
```

### Problem 5: Partition Labels (LeetCode 763)

```python
def partitionLabels(s):
    """
    Partition string into as many parts as possible
    where each letter appears in at most one part.
    
    Time: O(n), Space: O(1)
    """
    last = {c: i for i, c in enumerate(s)}
    result = []
    start = 0
    end = 0
    
    for i, c in enumerate(s):
        end = max(end, last[c])
        
        if i == end:
            result.append(end - start + 1)
            start = i + 1
    
    return result

print(partitionLabels("ababcbacadefegdehijhklij"))  # [9,7,8]
```

## Greedy vs DP

- **Greedy**: Make best local choice, O(n) or O(n log n)
- **DP**: Consider all choices, O(n²) or higher
- **When both work**: Greedy is simpler and faster

## Interview Tips

1. Prove greedy choice is optimal
2. Consider counterexamples
3. Sort when order matters
4. Be clear about what you're optimizing

## Summary

| Aspect | Details |
|--------|---------|
| **Complexity** | Usually O(n) or O(n log n) |
| **Difficulty** | Medium |
| **Key Skill** | Recognizing greedy property |
