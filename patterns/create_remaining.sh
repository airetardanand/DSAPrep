#!/bin/bash

# Pattern 18: Union-Find
cat > 18-union-find.md << 'EOF'
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
EOF

# Pattern 19: Bit Manipulation
cat > 19-bit-manipulation.md << 'EOF'
# Pattern 19: Bit Manipulation

## Overview
Bit manipulation uses bitwise operators for efficient computations on binary representations.

## Common Operations
```python
# Check if kth bit is set
def is_bit_set(n, k):
    return (n & (1 << k)) != 0

# Set kth bit
def set_bit(n, k):
    return n | (1 << k)

# Clear kth bit
def clear_bit(n, k):
    return n & ~(1 << k)

# Toggle kth bit
def toggle_bit(n, k):
    return n ^ (1 << k)

# Get rightmost set bit
def rightmost_set_bit(n):
    return n & -n

# Count set bits
def count_bits(n):
    count = 0
    while n:
        n &= n - 1  # Clear rightmost bit
        count += 1
    return count
```

## Key Problems

### Single Number (LeetCode 136)
```python
def singleNumber(nums):
    """Every element appears twice except one."""
    result = 0
    for num in nums:
        result ^= num
    return result

print(singleNumber([2,2,1]))  # 1
```

### Power of Two (LeetCode 231)
```python
def isPowerOfTwo(n):
    """Check if n is power of 2."""
    return n > 0 and (n & (n - 1)) == 0

print(isPowerOfTwo(16))  # True
```

### Subsets (using bit manipulation)
```python
def subsets(nums):
    n = len(nums)
    result = []
    for mask in range(1 << n):  # 2^n subsets
        subset = []
        for i in range(n):
            if mask & (1 << i):
                subset.append(nums[i])
        result.append(subset)
    return result
```

## Summary
- **Use**: Flags, set operations, optimization
- **Complexity**: Usually O(1) per operation
- **Key**: XOR for finding unique, AND/OR for masking
"""
EOF

# Pattern 20: Math Algorithms
cat > 20-math-algorithms.md << 'EOF'
# Pattern 20: Math Algorithms

## Overview
Common mathematical algorithms for competitive programming and interviews.

## Key Algorithms

### GCD (Greatest Common Divisor)
```python
def gcd(a, b):
    """Euclidean algorithm."""
    while b:
        a, b = b, a % b
    return a

def lcm(a, b):
    """Least Common Multiple."""
    return (a * b) // gcd(a, b)
```

### Sieve of Eratosthenes (Prime Numbers)
```python
def sieve_of_eratosthenes(n):
    """Find all primes up to n."""
    is_prime = [True] * (n + 1)
    is_prime[0] = is_prime[1] = False
    
    for i in range(2, int(n**0.5) + 1):
        if is_prime[i]:
            for j in range(i*i, n + 1, i):
                is_prime[j] = False
    
    return [i for i in range(n + 1) if is_prime[i]]

print(sieve_of_eratosthenes(30))  # [2,3,5,7,11,13,17,19,23,29]
```

### Fast Exponentiation
```python
def power_mod(base, exp, mod):
    """Compute (base^exp) % mod efficiently."""
    result = 1
    base = base % mod
    
    while exp > 0:
        if exp % 2 == 1:
            result = (result * base) % mod
        exp = exp >> 1
        base = (base * base) % mod
    
    return result
```

### Factorial with Modulo
```python
def factorial_mod(n, mod):
    """Factorial with modular arithmetic."""
    result = 1
    for i in range(1, n + 1):
        result = (result * i) % mod
    return result
```

## Key Problems

### Happy Number (LeetCode 202)
```python
def isHappy(n):
    """Check if sum of squares of digits eventually reaches 1."""
    seen = set()
    while n != 1 and n not in seen:
        seen.add(n)
        n = sum(int(d)**2 for d in str(n))
    return n == 1
```

### Pow(x, n) (LeetCode 50)
```python
def myPow(x, n):
    """Calculate x^n efficiently."""
    if n < 0:
        x = 1 / x
        n = -n
    
    result = 1
    current = x
    
    while n > 0:
        if n % 2 == 1:
            result *= current
        current *= current
        n //= 2
    
    return result
```

## Summary
- **GCD/LCM**: O(log(min(a,b)))
- **Sieve**: O(n log log n)
- **Fast Power**: O(log n)
"""
EOF

echo "Created patterns 18-20"
