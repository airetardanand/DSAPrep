# Pattern 14: Dijkstra's Algorithm

## Overview
Dijkstra's algorithm finds shortest paths from a source vertex to all other vertices in a weighted graph with non-negative edge weights.

## Implementation
```python
import heapq
from collections import defaultdict

def dijkstra(graph, start, n):
    """
    Dijkstra's shortest path algorithm.
    
    Args:
        graph: adjacency list {node: [(neighbor, weight), ...]}
        start: starting node
        n: total number of nodes
    
    Returns:
        distances: shortest distance to each node
    
    Time: O((V + E) log V), Space: O(V)
    """
    distances = [float('inf')] * n
    distances[start] = 0
    pq = [(0, start)]  # (distance, node)
    
    while pq:
        dist, node = heapq.heappop(pq)
        
        if dist > distances[node]:
            continue  # Already found better path
        
        for neighbor, weight in graph[node]:
            new_dist = dist + weight
            if new_dist < distances[neighbor]:
                distances[neighbor] = new_dist
                heapq.heappush(pq, (new_dist, neighbor))
    
    return distances
```

## Key Problems

### Network Delay Time (LeetCode 743)
```python
def networkDelayTime(times, n, k):
    """
    Minimum time for all nodes to receive signal.
    
    Times: [[source, target, time], ...]
    K: starting node (1-indexed)
    """
    graph = defaultdict(list)
    for u, v, w in times:
        graph[u].append((v, w))
    
    distances = [float('inf')] * (n + 1)
    distances[k] = 0
    pq = [(0, k)]
    
    while pq:
        time, node = heapq.heappop(pq)
        
        if time > distances[node]:
            continue
        
        for neighbor, weight in graph[node]:
            new_time = time + weight
            if new_time < distances[neighbor]:
                distances[neighbor] = new_time
                heapq.heappush(pq, (new_time, neighbor))
    
    max_time = max(distances[1:])
    return max_time if max_time != float('inf') else -1

print(networkDelayTime([[2,1,1],[2,3,1],[3,4,1]], 4, 2))  # 2
```

### Path with Minimum Effort (LeetCode 1631)
```python
def minimumEffortPath(heights):
    """
    Find path with minimum effort (max absolute difference).
    
    Time: O(mn log(mn)), Space: O(mn)
    """
    rows, cols = len(heights), len(heights[0])
    efforts = [[float('inf')] * cols for _ in range(rows)]
    efforts[0][0] = 0
    pq = [(0, 0, 0)]  # (effort, row, col)
    
    while pq:
        effort, row, col = heapq.heappop(pq)
        
        if row == rows-1 and col == cols-1:
            return effort
        
        if effort > efforts[row][col]:
            continue
        
        for dr, dc in [(0,1),(1,0),(0,-1),(-1,0)]:
            nr, nc = row + dr, col + dc
            if 0 <= nr < rows and 0 <= nc < cols:
                new_effort = max(effort, abs(heights[nr][nc] - heights[row][col]))
                if new_effort < efforts[nr][nc]:
                    efforts[nr][nc] = new_effort
                    heapq.heappush(pq, (new_effort, nr, nc))
    
    return 0
```

## Summary
- **Use**: Single-source shortest path, non-negative weights
- **Complexity**: O((V + E) log V) with binary heap
- **Can't handle**: Negative edge weights (use Bellman-Ford)
