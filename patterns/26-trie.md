# Pattern 26: Trie (Prefix Trees)

## Overview
Trie is a tree data structure for efficient string storage and retrieval.

## Implementation
```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    def insert(self, word):
        """Insert word into trie. Time: O(m)"""
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True
    
    def search(self, word):
        """Check if word exists. Time: O(m)"""
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end
    
    def startsWith(self, prefix):
        """Check if prefix exists. Time: O(m)"""
        node = self.root
        for char in prefix:
            if char not in node.children:
                return False
            node = node.children[char]
        return True
```

## Key Problems

### Word Search II (LeetCode 212)
```python
def findWords(board, words):
    trie = Trie()
    for word in words:
        trie.insert(word)
    
    result = set()
    rows, cols = len(board), len(board[0])
    
    def dfs(i, j, node, path):
        if node.is_end:
            result.add(path)
        
        if i < 0 or i >= rows or j < 0 or j >= cols:
            return
        
        char = board[i][j]
        if char not in node.children:
            return
        
        board[i][j] = '#'  # Mark visited
        for di, dj in [(0,1),(1,0),(0,-1),(-1,0)]:
            dfs(i+di, j+dj, node.children[char], path+char)
        board[i][j] = char  # Restore
    
    for i in range(rows):
        for j in range(cols):
            dfs(i, j, trie.root, "")
    
    return list(result)
```

## Summary
- **Operations**: O(m) where m is word length
- **Space**: O(ALPHABET_SIZE * N * M) worst case
- **Use**: Autocomplete, spell check, prefix matching
"""
