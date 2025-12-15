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
