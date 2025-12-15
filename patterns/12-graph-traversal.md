# Pattern 12: Graph Traversal (BFS/DFS)

## Overview

Graph traversal explores all vertices and edges systematically. Two main approaches: Breadth-First Search (BFS) and Depth-First Search (DFS).

## BFS vs DFS

**BFS** (Queue-based):
- Level-by-level exploration
- Shortest path in unweighted graphs
- More memory for wide graphs

**DFS** (Stack/Recursion):
- Deep exploration first
- Less memory for deep graphs
- Cycle detection, topological sort

## Key Problems

### Problem 1: Number of Islands (LeetCode 200)

```python
def numIslands(grid):
    """
    Count number of islands in 2D grid.
    1 = land, 0 = water
    
    Time: O(m*n), Space: O(min(m,n))
    """
    if not grid:
        return 0
    
    count = 0
    rows, cols = len(grid), len(grid[0])
    
    def dfs(i, j):
        if (i < 0 or i >= rows or j < 0 or j >= cols or 
            grid[i][j] == '0'):
            return
        
        grid[i][j] = '0'  # Mark visited
        
        # Explore 4 directions
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    
    for i in range(rows):
        for j in range(cols):
            if grid[i][j] == '1':
                count += 1
                dfs(i, j)
    
    return count

grid = [
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
]
print(numIslands(grid))  # 3
```

### Problem 2: Clone Graph (LeetCode 133)

```python
class Node:
    def __init__(self, val=0, neighbors=None):
        self.val = val
        self.neighbors = neighbors if neighbors else []

def cloneGraph(node):
    """
    Deep copy of graph.
    
    Time: O(V + E), Space: O(V)
    """
    if not node:
        return None
    
    clones = {}
    
    def dfs(node):
        if node in clones:
            return clones[node]
        
        clone = Node(node.val)
        clones[node] = clone
        
        for neighbor in node.neighbors:
            clone.neighbors.append(dfs(neighbor))
        
        return clone
    
    return dfs(node)
```

### Problem 3: Shortest Path in Binary Matrix (LeetCode 1091)

```python
from collections import deque

def shortestPathBinaryMatrix(grid):
    """
    Shortest path from top-left to bottom-right.
    Can move in 8 directions.
    
    Time: O(n²), Space: O(n²)
    """
    n = len(grid)
    if grid[0][0] == 1 or grid[n-1][n-1] == 1:
        return -1
    
    directions = [(0,1),(1,0),(0,-1),(-1,0),(1,1),(-1,-1),(1,-1),(-1,1)]
    queue = deque([(0, 0, 1)])  # (row, col, distance)
    visited = {(0, 0)}
    
    while queue:
        row, col, dist = queue.popleft()
        
        if row == n-1 and col == n-1:
            return dist
        
        for dr, dc in directions:
            r, c = row + dr, col + dc
            if (0 <= r < n and 0 <= c < n and 
                grid[r][c] == 0 and (r, c) not in visited):
                visited.add((r, c))
                queue.append((r, c, dist + 1))
    
    return -1

print(shortestPathBinaryMatrix([[0,0,0],[1,1,0],[1,1,0]]))  # 4
```

### Problem 4: Surrounded Regions (LeetCode 130)

```python
def solve(board):
    """
    Capture surrounded regions.
    'O' surrounded by 'X' becomes 'X'.
    
    Time: O(m*n), Space: O(m*n)
    """
    if not board:
        return
    
    rows, cols = len(board), len(board[0])
    
    def dfs(i, j):
        if (i < 0 or i >= rows or j < 0 or j >= cols or
            board[i][j] != 'O'):
            return
        
        board[i][j] = 'T'  # Temporary mark
        
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    
    # Mark border-connected 'O's
    for i in range(rows):
        dfs(i, 0)
        dfs(i, cols-1)
    for j in range(cols):
        dfs(0, j)
        dfs(rows-1, j)
    
    # Flip remaining 'O' to 'X', restore 'T' to 'O'
    for i in range(rows):
        for j in range(cols):
            if board[i][j] == 'O':
                board[i][j] = 'X'
            elif board[i][j] == 'T':
                board[i][j] = 'O'
```

### Problem 5: Pacific Atlantic Water Flow (LeetCode 417)

```python
def pacificAtlantic(heights):
    """
    Find cells where water can flow to both oceans.
    
    Time: O(m*n), Space: O(m*n)
    """
    if not heights:
        return []
    
    rows, cols = len(heights), len(heights[0])
    pacific = set()
    atlantic = set()
    
    def dfs(i, j, visited):
        visited.add((i, j))
        
        for di, dj in [(0,1),(1,0),(0,-1),(-1,0)]:
            ni, nj = i + di, j + dj
            if (0 <= ni < rows and 0 <= nj < cols and
                (ni, nj) not in visited and
                heights[ni][nj] >= heights[i][j]):
                dfs(ni, nj, visited)
    
    # DFS from pacific edges
    for i in range(rows):
        dfs(i, 0, pacific)
    for j in range(cols):
        dfs(0, j, pacific)
    
    # DFS from atlantic edges
    for i in range(rows):
        dfs(i, cols-1, atlantic)
    for j in range(cols):
        dfs(rows-1, j, atlantic)
    
    return list(pacific & atlantic)
```

## When to Use Which

- **BFS**: Shortest path, level-order, nearest
- **DFS**: Connectivity, cycles, paths, backtracking
- **Both work**: Count components, reachability

## Interview Tips

1. Choose BFS for shortest path
2. Use DFS for simpler recursion
3. Mark visited to avoid cycles
4. Consider iterative vs recursive

## Summary

| Aspect | Details |
|--------|---------|
| **Complexity** | O(V + E) time |
| **Space** | O(V) for visited set |
| **Difficulty** | Medium |
