# Pattern 25: Tree Traversal (BFS/DFS/LCA)

## Overview
Tree traversal patterns including DFS (inorder, preorder, postorder), BFS, and Lowest Common Ancestor.

## Node Definition
```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
```

## DFS Traversals

### Inorder (Left-Root-Right)
```python
def inorderTraversal(root):
    result = []
    
    def dfs(node):
        if not node:
            return
        dfs(node.left)
        result.append(node.val)
        dfs(node.right)
    
    dfs(root)
    return result
```

### Preorder (Root-Left-Right)
```python
def preorderTraversal(root):
    if not root:
        return []
    return [root.val] + preorderTraversal(root.left) + preorderTraversal(root.right)
```

### Postorder (Left-Right-Root)
```python
def postorderTraversal(root):
    result = []
    
    def dfs(node):
        if not node:
            return
        dfs(node.left)
        dfs(node.right)
        result.append(node.val)
    
    dfs(root)
    return result
```

## BFS (Level Order)
```python
from collections import deque

def levelOrder(root):
    if not root:
        return []
    
    result = []
    queue = deque([root])
    
    while queue:
        level = []
        for _ in range(len(queue)):
            node = queue.popleft()
            level.append(node.val)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        result.append(level)
    
    return result
```

## Lowest Common Ancestor (LeetCode 236)
```python
def lowestCommonAncestor(root, p, q):
    if not root or root == p or root == q:
        return root
    
    left = lowestCommonAncestor(root.left, p, q)
    right = lowestCommonAncestor(root.right, p, q)
    
    if left and right:
        return root
    return left or right
```

## Summary
- **DFS**: O(n) time, O(h) space for recursion
- **BFS**: O(n) time, O(w) space for queue (w=max width)
- **Use**: DFS for paths, BFS for levels
"""
