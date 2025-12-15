# Pattern 23: Hashmap & Frequency Counting

## Overview
Hash maps enable O(1) lookups and are essential for frequency counting and caching.

## Key Problems

### Two Sum (LeetCode 1)
```python
def twoSum(nums, target):
    seen = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    return []

print(twoSum([2,7,11,15], 9))  # [0,1]
```

### Group Anagrams (LeetCode 49)
```python
from collections import defaultdict

def groupAnagrams(strs):
    groups = defaultdict(list)
    for s in strs:
        key = tuple(sorted(s))
        groups[key].append(s)
    return list(groups.values())

print(groupAnagrams(["eat","tea","tan","ate","nat","bat"]))
# [["eat","tea","ate"],["tan","nat"],["bat"]]
```

### Top K Frequent Elements (LeetCode 347)
```python
from collections import Counter
import heapq

def topKFrequent(nums, k):
    count = Counter(nums)
    return heapq.nlargest(k, count.keys(), key=count.get)

print(topKFrequent([1,1,1,2,2,3], 2))  # [1,2]
```

### LRU Cache (LeetCode 146)
```python
from collections import OrderedDict

class LRUCache:
    def __init__(self, capacity):
        self.cache = OrderedDict()
        self.capacity = capacity
    
    def get(self, key):
        if key not in self.cache:
            return -1
        self.cache.move_to_end(key)
        return self.cache[key]
    
    def put(self, key, value):
        if key in self.cache:
            self.cache.move_to_end(key)
        self.cache[key] = value
        if len(self.cache) > self.capacity:
            self.cache.popitem(last=False)
```

## Summary
- **Use**: Fast lookup, counting, caching
- **Complexity**: O(1) average for operations
"""
