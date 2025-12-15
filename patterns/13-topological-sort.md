# Pattern 13: Topological Sort

## Overview
Topological sort produces a linear ordering of vertices in a Directed Acyclic Graph (DAG) where for every directed edge u→v, u comes before v.

## Applications
- Course scheduling with prerequisites
- Build systems (dependency resolution)
- Task scheduling

## Algorithms

### 1. Kahn's Algorithm (BFS-based)
```python
from collections import deque, defaultdict

def topological_sort_kahn(n, prerequisites):
    """
    Kahn's algorithm using BFS.
    Time: O(V + E), Space: O(V + E)
    """
    graph = defaultdict(list)
    in_degree = [0] * n
    
    for dest, src in prerequisites:
        graph[src].append(dest)
        in_degree[dest] += 1
    
    queue = deque([i for i in range(n) if in_degree[i] == 0])
    result = []
    
    while queue:
        node = queue.popleft()
        result.append(node)
        
        for neighbor in graph[node]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                queue.append(neighbor)
    
    return result if len(result) == n else []

print(topological_sort_kahn(4, [[1,0],[2,0],[3,1],[3,2]]))  # [0,1,2,3] or [0,2,1,3]
```

### 2. DFS-based Approach
```python
def topological_sort_dfs(n, prerequisites):
    """
    DFS-based topological sort.
    Time: O(V + E), Space: O(V + E)
    """
    graph = defaultdict(list)
    for dest, src in prerequisites:
        graph[src].append(dest)
    
    visited = [0] * n  # 0=unvisited, 1=visiting, 2=visited
    result = []
    
    def dfs(node):
        if visited[node] == 1:
            return False  # Cycle detected
        if visited[node] == 2:
            return True   # Already processed
        
        visited[node] = 1
        for neighbor in graph[node]:
            if not dfs(neighbor):
                return False
        
        visited[node] = 2
        result.append(node)
        return True
    
    for i in range(n):
        if visited[i] == 0:
            if not dfs(i):
                return []  # Cycle exists
    
    return result[::-1]  # Reverse for correct order
```

## Key Problems

### Course Schedule (LeetCode 207)
```python
def canFinish(numCourses, prerequisites):
    """Can finish all courses?"""
    return len(topological_sort_kahn(numCourses, prerequisites)) == numCourses

print(canFinish(2, [[1,0]]))  # True
print(canFinish(2, [[1,0],[0,1]]))  # False (cycle)
```

### Course Schedule II (LeetCode 210)
```python
def findOrder(numCourses, prerequisites):
    """Return course order."""
    return topological_sort_kahn(numCourses, prerequisites)
```

## Summary
- **Kahn's**: Easier to understand, detects cycles naturally
- **DFS**: More elegant, uses less space
- **Both**: O(V + E) time complexity
