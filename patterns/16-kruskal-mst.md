# Pattern 16: Minimum Spanning Tree (Kruskal's)

## Overview
Kruskal's algorithm finds MST by adding edges in order of increasing weight, skipping edges that would create cycles.

## Implementation (with Union-Find)
```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def union(self, x, y):
        px, py = self.find(x), self.find(y)
        if px == py:
            return False
        if self.rank[px] < self.rank[py]:
            px, py = py, px
        self.parent[py] = px
        if self.rank[px] == self.rank[py]:
            self.rank[px] += 1
        return True

def kruskal_mst(n, edges):
    """
    Kruskal's MST algorithm.
    
    Args:
        n: number of nodes
        edges: [(u, v, weight), ...]
    
    Returns:
        MST weight and edges
    
    Time: O(E log E), Space: O(V)
    """
    uf = UnionFind(n)
    edges.sort(key=lambda x: x[2])  # Sort by weight
    
    mst_weight = 0
    mst_edges = []
    
    for u, v, weight in edges:
        if uf.union(u, v):
            mst_weight += weight
            mst_edges.append((u, v, weight))
            if len(mst_edges) == n - 1:
                break
    
    return mst_weight, mst_edges
```

## Key Problem: Min Cost to Connect All Points (LeetCode 1584)
```python
def minCostConnectPoints(points):
    """
    Connect all points with minimum cost.
    Cost = Manhattan distance.
    
    Time: O(n² log n), Space: O(n²)
    """
    n = len(points)
    
    # Generate all edges
    edges = []
    for i in range(n):
        for j in range(i + 1, n):
            dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
            edges.append((i, j, dist))
    
    # Kruskal's algorithm
    uf = UnionFind(n)
    edges.sort(key=lambda x: x[2])
    
    cost = 0
    for u, v, weight in edges:
        if uf.union(u, v):
            cost += weight
    
    return cost

print(minCostConnectPoints([[0,0],[2,2],[3,10],[5,2],[7,0]]))  # 20
```

## Summary
- **Use**: MST in sparse graphs
- **Complexity**: O(E log E) for sorting
- **Needs**: Union-Find data structure
