# Pattern 15: Bellman-Ford Algorithm

## Overview
Bellman-Ford finds shortest paths even with negative edge weights and can detect negative cycles.

## Implementation
```python
def bellman_ford(edges, n, src):
    """
    Bellman-Ford shortest path algorithm.
    
    Args:
        edges: List of (u, v, weight) tuples
        n: number of nodes
        src: source node
    
    Returns:
        distances or None if negative cycle
    
    Time: O(V * E), Space: O(V)
    """
    distances = [float('inf')] * n
    distances[src] = 0
    
    # Relax edges V-1 times
    for _ in range(n - 1):
        for u, v, weight in edges:
            if distances[u] != float('inf') and distances[u] + weight < distances[v]:
                distances[v] = distances[u] + weight
    
    # Check for negative cycles
    for u, v, weight in edges:
        if distances[u] != float('inf') and distances[u] + weight < distances[v]:
            return None  # Negative cycle detected
    
    return distances
```

## Key Problems

### Cheapest Flights Within K Stops (LeetCode 787)
```python
def findCheapestPrice(n, flights, src, dst, k):
    """
    Find cheapest price with at most k stops.
    
    Time: O(k * E), Space: O(V)
    """
    prices = [float('inf')] * n
    prices[src] = 0
    
    # Relax edges k+1 times (k stops means k+1 edges)
    for _ in range(k + 1):
        temp = prices.copy()
        for u, v, price in flights:
            if prices[u] != float('inf'):
                temp[v] = min(temp[v], prices[u] + price)
        prices = temp
    
    return prices[dst] if prices[dst] != float('inf') else -1

print(findCheapestPrice(3, [[0,1,100],[1,2,100],[0,2,500]], 0, 2, 1))  # 200
```

## Summary
- **Use**: Negative weights, cycle detection
- **Complexity**: O(V * E) time
- **Advantage**: Handles negative weights, detects negative cycles
- **Disadvantage**: Slower than Dijkstra for non-negative weights
