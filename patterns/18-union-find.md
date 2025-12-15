# Pattern 18: Union-Find (Disjoint Set Union)

## Overview
Union-Find (DSU) efficiently manages disjoint sets with two operations:
- **Find**: Determine which set an element belongs to
- **Union**: Merge two sets

## Implementation
```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
        self.count = n  # Number of disjoint sets
    
    def find(self, x):
        """Find with path compression."""
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def union(self, x, y):
        """Union by rank."""
        px, py = self.find(x), self.find(y)
        if px == py:
            return False
        
        if self.rank[px] < self.rank[py]:
            px, py = py, px
        
        self.parent[py] = px
        if self.rank[px] == self.rank[py]:
            self.rank[px] += 1
        
        self.count -= 1
        return True
    
    def connected(self, x, y):
        """Check if x and y are in same set."""
        return self.find(x) == self.find(y)
```

## Key Problems

### Number of Connected Components (LeetCode 323)
```python
def countComponents(n, edges):
    uf = UnionFind(n)
    for u, v in edges:
        uf.union(u, v)
    return uf.count
```

### Accounts Merge (LeetCode 721)
```python
from collections import defaultdict

def accountsMerge(accounts):
    uf = UnionFind(len(accounts))
    email_to_id = {}
    
    for i, account in enumerate(accounts):
        for email in account[1:]:
            if email in email_to_id:
                uf.union(i, email_to_id[email])
            else:
                email_to_id[email] = i
    
    groups = defaultdict(list)
    for email, id in email_to_id.items():
        groups[uf.find(id)].append(email)
    
    result = []
    for id, emails in groups.items():
        result.append([accounts[id][0]] + sorted(emails))
    
    return result
```

## Summary
- **Operations**: O(α(n)) amortized (nearly constant)
- **Use**: Connected components, cycle detection, MST
- **Space**: O(n)
"""
