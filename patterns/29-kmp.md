# Pattern 29: KMP String Matching

## Overview
Knuth-Morris-Pratt (KMP) algorithm efficiently finds pattern in text using failure function.

## Implementation
```python
def kmp_search(text, pattern):
    """
    Find all occurrences of pattern in text.
    
    Time: O(n + m), Space: O(m)
    n = len(text), m = len(pattern)
    """
    def build_lps(pattern):
        """Build longest proper prefix which is also suffix array."""
        m = len(pattern)
        lps = [0] * m
        length = 0
        i = 1
        
        while i < m:
            if pattern[i] == pattern[length]:
                length += 1
                lps[i] = length
                i += 1
            else:
                if length != 0:
                    length = lps[length - 1]
                else:
                    lps[i] = 0
                    i += 1
        
        return lps
    
    n, m = len(text), len(pattern)
    lps = build_lps(pattern)
    result = []
    
    i = j = 0
    while i < n:
        if text[i] == pattern[j]:
            i += 1
            j += 1
        
        if j == m:
            result.append(i - j)
            j = lps[j - 1]
        elif i < n and text[i] != pattern[j]:
            if j != 0:
                j = lps[j - 1]
            else:
                i += 1
    
    return result

print(kmp_search("ababcababcabc", "abc"))  # [2, 7, 10]
```

## Key Problem: Implement strStr() (LeetCode 28)
```python
def strStr(haystack, needle):
    if not needle:
        return 0
    
    matches = kmp_search(haystack, needle)
    return matches[0] if matches else -1

print(strStr("hello", "ll"))  # 2
```

## Summary
- **Time**: O(n + m) vs naive O(n*m)
- **Space**: O(m) for LPS array
- **Use**: Pattern matching, repeated search
"""
