# Pattern 17: Minimum Spanning Tree (Prim's)

## Overview
Prim's algorithm builds MST by starting from any vertex and repeatedly adding the minimum weight edge that connects the tree to a new vertex.

## Implementation
```python
import heapq
from collections import defaultdict

def prim_mst(n, edges):
    """
    Prim's MST algorithm.
    
    Args:
        n: number of nodes
        edges: [(u, v, weight), ...]
    
    Returns:
        MST weight
    
    Time: O(E log V), Space: O(V + E)
    """
    graph = defaultdict(list)
    for u, v, weight in edges:
        graph[u].append((v, weight))
        graph[v].append((u, weight))
    
    visited = set()
    pq = [(0, 0)]  # (weight, node) - start from node 0
    mst_weight = 0
    
    while pq and len(visited) < n:
        weight, node = heapq.heappop(pq)
        
        if node in visited:
            continue
        
        visited.add(node)
        mst_weight += weight
        
        for neighbor, edge_weight in graph[node]:
            if neighbor not in visited:
                heapq.heappush(pq, (edge_weight, neighbor))
    
    return mst_weight
```

## Key Problem: Min Cost to Connect All Points
```python
def minCostConnectPoints(points):
    """
    Prim's algorithm for connecting points.
    
    Time: O(n² log n), Space: O(n)
    """
    n = len(points)
    visited = set([0])
    pq = []
    
    # Add all edges from point 0
    for j in range(1, n):
        dist = abs(points[0][0] - points[j][0]) + abs(points[0][1] - points[j][1])
        heapq.heappush(pq, (dist, j))
    
    cost = 0
    while len(visited) < n:
        dist, point = heapq.heappop(pq)
        
        if point in visited:
            continue
        
        visited.add(point)
        cost += dist
        
        # Add edges from new point
        for j in range(n):
            if j not in visited:
                new_dist = abs(points[point][0] - points[j][0]) + abs(points[point][1] - points[j][1])
                heapq.heappush(pq, (new_dist, j))
    
    return cost
```

## Summary
- **Use**: MST in dense graphs
- **Complexity**: O(E log V) with binary heap
- **vs Kruskal's**: Better for dense graphs (E ≈ V²)
