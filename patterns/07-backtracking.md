# Pattern 7: Backtracking & Recursion

## Table of Contents
1. [Overview](#overview)
2. [Pattern Variations](#pattern-variations)
3. [Core Concepts](#core-concepts)
4. [Detailed Implementations](#detailed-implementations)
5. [Complexity Analysis](#complexity-analysis)
6. [Example Problems](#example-problems)
7. [Use Cases and Best Practices](#use-cases-and-best-practices)
8. [Common Pitfalls](#common-pitfalls)

## Overview

Backtracking is a systematic way to explore all possible solutions by building candidates incrementally and abandoning them ("backtracking") when they cannot lead to valid solutions. This pattern is essential for:

- Generating combinations and permutations
- Constraint satisfaction problems
- Path finding with obstacles
- Puzzle solving (N-Queens, Sudoku)
- Subset generation

**Key Advantage**: Explores solution space efficiently by pruning invalid branches early.

## Pattern Variations

### 1. **Subset Generation**
- Generate all subsets/combinations
- **Time**: O(2^n), **Space**: O(n) recursion depth
- **Best for**: Power set, combinations

### 2. **Permutation Generation**
- Generate all arrangements
- **Time**: O(n!), **Space**: O(n)
- **Best for**: All orderings, arrangements

### 3. **Constraint Satisfaction**
- Find solutions satisfying constraints
- **Time**: Exponential (pruned), **Space**: O(n)
- **Best for**: N-Queens, Sudoku, graph coloring

### 4. **Path Finding**
- Find paths in grid/graph
- **Time**: O(4^(m*n)) worst case, **Space**: O(m*n)
- **Best for**: Maze solving, word search

---

## Core Concepts

### When to Use Backtracking?

✓ **Use when:**
- Need to explore all possible solutions
- Problem has constraints to prune search space
- Building solution incrementally
- Can recognize invalid states early
- No better algorithmic approach (DP, greedy)

✗ **Don't use when:**
- Solution space is too large without pruning
- Problem has optimal substructure (use DP)
- Greedy choice property exists

### Backtracking Template

```python
def backtrack(state, choices, results):
    """
    General backtracking template
    
    Args:
        state: Current partial solution
        choices: Available choices at this state
        results: Collection of valid solutions
    """
    # Base case: check if state is a valid solution
    if is_valid_solution(state):
        results.append(state.copy())  # Important: copy state!
        return
    
    # Recursive case: try each choice
    for choice in choices:
        # Make choice
        state.add(choice)
        
        # Recurse with updated state
        backtrack(state, get_new_choices(state), results)
        
        # Undo choice (backtrack)
        state.remove(choice)
```

### Key Principles

1. **Choose**: Make a choice and add it to current solution
2. **Explore**: Recursively explore with that choice
3. **Unchoose**: Remove choice and try next option (backtrack)
4. **Prune**: Skip invalid branches early for efficiency

---

## Detailed Implementations

### Pattern 1: Subsets (Power Set)

```python
def subsets(nums):
    """
    Generate all subsets of a set.
    
    Args:
        nums: List of distinct integers
    
    Returns:
        List of all subsets
    
    Time: O(2^n * n), Space: O(n) recursion depth
    
    Example: [1,2,3] -> [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
    """
    result = []
    
    def backtrack(start, current):
        # Every state is a valid subset
        result.append(current[:])  # Add copy
        
        # Try adding each remaining element
        for i in range(start, len(nums)):
            current.append(nums[i])      # Choose
            backtrack(i + 1, current)     # Explore
            current.pop()                 # Unchoose
    
    backtrack(0, [])
    return result

# Test cases
print(subsets([1, 2, 3]))
# [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]
print(subsets([0]))  # [[], [0]]
```

### Pattern 2: Permutations

```python
def permute(nums):
    """
    Generate all permutations.
    
    Args:
        nums: List of distinct integers
    
    Returns:
        List of all permutations
    
    Time: O(n! * n), Space: O(n)
    
    Example: [1,2,3] -> [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
    """
    result = []
    
    def backtrack(current, remaining):
        # Base case: no more elements to add
        if not remaining:
            result.append(current[:])
            return
        
        # Try each remaining element
        for i in range(len(remaining)):
            # Choose element at index i
            current.append(remaining[i])
            # Explore with remaining elements (excluding i)
            backtrack(current, remaining[:i] + remaining[i+1:])
            # Unchoose
            current.pop()
    
    backtrack([], nums)
    return result

# Test cases
print(permute([1, 2, 3]))
# [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
print(permute([0, 1]))  # [[0,1],[1,0]]
```

### Pattern 3: Combinations

```python
def combine(n, k):
    """
    Generate all combinations of k numbers from 1 to n.
    
    Args:
        n: Range of numbers (1 to n)
        k: Size of each combination
    
    Returns:
        List of all combinations
    
    Time: O(C(n,k) * k), Space: O(k)
    
    Example: n=4, k=2 -> [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
    """
    result = []
    
    def backtrack(start, current):
        # Base case: combination complete
        if len(current) == k:
            result.append(current[:])
            return
        
        # Try numbers from start to n
        for i in range(start, n + 1):
            current.append(i)
            backtrack(i + 1, current)
            current.pop()
    
    backtrack(1, [])
    return result

# Test cases
print(combine(4, 2))  # [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
print(combine(1, 1))  # [[1]]
```

### Pattern 4: N-Queens

```python
def solveNQueens(n):
    """
    Solve N-Queens problem: place n queens on n×n board.
    
    Args:
        n: Board size and number of queens
    
    Returns:
        All distinct solutions
    
    Time: O(n!), Space: O(n²)
    
    Example: n=4 -> [["..Q.","Q...","...Q",".Q.."],
                     [".Q..","...Q","Q...","..Q."]]
    """
    result = []
    board = [['.'] * n for _ in range(n)]
    cols = set()
    diag1 = set()  # row - col
    diag2 = set()  # row + col
    
    def backtrack(row):
        if row == n:
            # Found valid solution
            result.append([''.join(row) for row in board])
            return
        
        for col in range(n):
            # Check if position is safe
            if col in cols or (row - col) in diag1 or (row + col) in diag2:
                continue
            
            # Place queen
            board[row][col] = 'Q'
            cols.add(col)
            diag1.add(row - col)
            diag2.add(row + col)
            
            # Explore
            backtrack(row + 1)
            
            # Remove queen (backtrack)
            board[row][col] = '.'
            cols.remove(col)
            diag1.remove(row - col)
            diag2.remove(row + col)
    
    backtrack(0)
    return result

# Test cases
print(len(solveNQueens(4)))  # 2 solutions
print(len(solveNQueens(8)))  # 92 solutions
```

### Pattern 5: Word Search

```python
def exist(board, word):
    """
    Check if word exists in board by connecting adjacent cells.
    
    Args:
        board: 2D grid of characters
        word: Target word
    
    Returns:
        True if word exists
    
    Time: O(m*n*4^L), Space: O(L) where L is word length
    
    Example: board = [["A","B","C","E"],
                      ["S","F","C","S"],
                      ["A","D","E","E"]], word = "ABCCED"
             Output: True
    """
    if not board or not board[0]:
        return False
    
    rows, cols = len(board), len(board[0])
    
    def backtrack(row, col, index):
        # Base case: found all characters
        if index == len(word):
            return True
        
        # Check boundaries and character match
        if (row < 0 or row >= rows or col < 0 or col >= cols or
            board[row][col] != word[index]):
            return False
        
        # Mark as visited (in-place)
        temp = board[row][col]
        board[row][col] = '#'
        
        # Explore all 4 directions
        found = (backtrack(row + 1, col, index + 1) or
                 backtrack(row - 1, col, index + 1) or
                 backtrack(row, col + 1, index + 1) or
                 backtrack(row, col - 1, index + 1))
        
        # Restore cell (backtrack)
        board[row][col] = temp
        
        return found
    
    # Try starting from each cell
    for i in range(rows):
        for j in range(cols):
            if backtrack(i, j, 0):
                return True
    
    return False

# Test cases
board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]]
print(exist(board, "ABCCED"))  # True
print(exist(board, "SEE"))     # True
print(exist(board, "ABCB"))    # False
```

---

## Complexity Analysis

### Time Complexity

| Pattern | Complexity | Explanation |
|---------|-----------|-------------|
| Subsets | O(2^n * n) | 2^n subsets, O(n) to copy each |
| Permutations | O(n! * n) | n! permutations, O(n) to copy |
| Combinations | O(C(n,k) * k) | C(n,k) combinations |
| N-Queens | O(n!) | Pruned branching factor |
| Word Search | O(m*n*4^L) | Try each cell, 4 directions, L depth |

### Space Complexity

- **Recursion Stack**: O(n) or O(L) for depth
- **State Storage**: O(n) for tracking choices
- **Result Storage**: Exponential based on number of solutions

---

## Example Problems

### Problem 1: Combination Sum (LeetCode 39)

```python
def combinationSum(candidates, target):
    """
    LeetCode 39: Combination Sum
    
    Find all unique combinations that sum to target.
    Same number can be used multiple times.
    
    Args:
        candidates: Array of distinct integers
        target: Target sum
    
    Returns:
        All unique combinations
    
    Example:
        Input: candidates = [2,3,6,7], target = 7
        Output: [[2,2,3],[7]]
    """
    result = []
    
    def backtrack(start, current, current_sum):
        if current_sum == target:
            result.append(current[:])
            return
        
        if current_sum > target:
            return  # Prune: sum exceeded
        
        for i in range(start, len(candidates)):
            current.append(candidates[i])
            # Can reuse same element: pass i (not i+1)
            backtrack(i, current, current_sum + candidates[i])
            current.pop()
    
    backtrack(0, [], 0)
    return result

# Test cases
print(combinationSum([2, 3, 6, 7], 7))  # [[2,2,3],[7]]
print(combinationSum([2, 3, 5], 8))     # [[2,2,2,2],[2,3,3],[3,5]]
```

### Problem 2: Palindrome Partitioning (LeetCode 131)

```python
def partition(s):
    """
    LeetCode 131: Palindrome Partitioning
    
    Partition string such that every substring is a palindrome.
    
    Args:
        s: Input string
    
    Returns:
        All possible palindrome partitioning
    
    Example:
        Input: s = "aab"
        Output: [["a","a","b"],["aa","b"]]
    """
    def is_palindrome(string):
        return string == string[::-1]
    
    result = []
    
    def backtrack(start, current):
        if start == len(s):
            result.append(current[:])
            return
        
        for end in range(start + 1, len(s) + 1):
            substring = s[start:end]
            if is_palindrome(substring):
                current.append(substring)
                backtrack(end, current)
                current.pop()
    
    backtrack(0, [])
    return result

# Test cases
print(partition("aab"))  # [["a","a","b"],["aa","b"]]
print(partition("a"))    # [["a"]]
```

### Problem 3: Letter Combinations of Phone Number (LeetCode 17)

```python
def letterCombinations(digits):
    """
    LeetCode 17: Letter Combinations of a Phone Number
    
    Generate all letter combinations for given phone digits.
    
    Args:
        digits: String of digits 2-9
    
    Returns:
        All possible letter combinations
    
    Example:
        Input: digits = "23"
        Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
    """
    if not digits:
        return []
    
    phone = {
        '2': 'abc', '3': 'def', '4': 'ghi', '5': 'jkl',
        '6': 'mno', '7': 'pqrs', '8': 'tuv', '9': 'wxyz'
    }
    
    result = []
    
    def backtrack(index, current):
        if index == len(digits):
            result.append(current)
            return
        
        digit = digits[index]
        for letter in phone[digit]:
            backtrack(index + 1, current + letter)
    
    backtrack(0, "")
    return result

# Test cases
print(letterCombinations("23"))
# ["ad","ae","af","bd","be","bf","cd","ce","cf"]
print(letterCombinations(""))   # []
print(letterCombinations("2"))  # ["a","b","c"]
```

### Problem 4: Generate Parentheses (LeetCode 22)

```python
def generateParenthesis(n):
    """
    LeetCode 22: Generate Parentheses
    
    Generate all combinations of well-formed parentheses.
    
    Args:
        n: Number of pairs of parentheses
    
    Returns:
        All valid combinations
    
    Example:
        Input: n = 3
        Output: ["((()))","(()())","(())()","()(())","()()()"]
    """
    result = []
    
    def backtrack(current, open_count, close_count):
        if len(current) == 2 * n:
            result.append(current)
            return
        
        # Add '(' if we haven't used all opening brackets
        if open_count < n:
            backtrack(current + '(', open_count + 1, close_count)
        
        # Add ')' if it won't make expression invalid
        if close_count < open_count:
            backtrack(current + ')', open_count, close_count + 1)
    
    backtrack("", 0, 0)
    return result

# Test cases
print(generateParenthesis(3))
# ["((()))","(()())","(())()","()(())","()()()"]
print(generateParenthesis(1))  # ["()"]
```

### Problem 5: Sudoku Solver (LeetCode 37)

```python
def solveSudoku(board):
    """
    LeetCode 37: Sudoku Solver
    
    Solve Sudoku puzzle using backtracking.
    
    Args:
        board: 9x9 Sudoku board ('.' for empty)
    
    Returns:
        None (modifies board in-place)
    """
    def is_valid(row, col, num):
        # Check row
        if num in board[row]:
            return False
        
        # Check column
        if num in [board[i][col] for i in range(9)]:
            return False
        
        # Check 3x3 box
        box_row, box_col = 3 * (row // 3), 3 * (col // 3)
        for i in range(box_row, box_row + 3):
            for j in range(box_col, box_col + 3):
                if board[i][j] == num:
                    return False
        
        return True
    
    def backtrack():
        for i in range(9):
            for j in range(9):
                if board[i][j] == '.':
                    for num in '123456789':
                        if is_valid(i, j, num):
                            board[i][j] = num
                            
                            if backtrack():
                                return True
                            
                            board[i][j] = '.'  # Backtrack
                    
                    return False  # No valid number found
        
        return True  # All cells filled
    
    backtrack()

# Test case
board = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]
solveSudoku(board)
# Board is solved in-place
```

---

## Use Cases and Best Practices

### Best Use Cases

1. **Combinatorial Problems**
   - Subsets, permutations, combinations
   - All possible solutions

2. **Constraint Satisfaction**
   - N-Queens, Sudoku
   - Graph coloring

3. **Path Finding**
   - Maze solving
   - Word search in grids

4. **Decision Problems**
   - Can we achieve target?
   - All ways to achieve something

### Best Practices

✓ **Do's**
- Prune early: check constraints before recursing
- Use sets/arrays to track used elements efficiently
- Copy state when adding to results
- Consider iterative approaches for small problems
- Optimize with memoization if overlapping subproblems

✗ **Don'ts**
- Don't forget to backtrack (undo changes)
- Don't use backtracking when DP is better
- Don't modify global state without restoration
- Don't create unnecessary copies in recursion
- Don't forget base cases

---

## Common Pitfalls

### Pitfall 1: Forgetting to Copy State

```python
# ❌ WRONG: All results reference same list
result.append(current)  # All entries are same object!

# ✓ CORRECT: Create copy
result.append(current[:])  # or current.copy()
```

### Pitfall 2: Not Backtracking Properly

```python
# ❌ WRONG: State not restored
current.append(choice)
backtrack(...)
# Forgot to remove choice!

# ✓ CORRECT: Always restore state
current.append(choice)
backtrack(...)
current.pop()
```

### Pitfall 3: Incorrect Pruning

```python
# ❌ WRONG: Pruning valid solutions
if current_sum >= target:
    return  # Might miss valid solutions!

# ✓ CORRECT: Only prune invalid cases
if current_sum > target:
    return
if current_sum == target:
    result.append(current[:])
    return
```

---

## Interview Tips

### How to Approach

1. **Identify backtracking structure**
   - Build solution incrementally?
   - Can abandon partial solutions?
   - Need all solutions or just one?

2. **Define state and choices**
   - What's in partial solution?
   - What choices available at each step?
   - When is solution complete?

3. **Implement three steps**
   - Choose
   - Explore
   - Unchoose

4. **Add pruning**
   - What makes state invalid?
   - Can we detect early?

### What Interviewers Look For

✓ Clear recursive structure
✓ Proper state management
✓ Efficient pruning
✓ Correct backtracking
✓ Complexity analysis

---

## Summary

| Aspect | Details |
|--------|---------|
| **When to use** | All solutions, constraints, combinations |
| **Main advantage** | Systematic exploration with pruning |
| **Complexity** | Exponential, but pruned |
| **Space** | O(n) recursion depth |
| **Difficulty** | Medium to Hard |

**Related Patterns:**
- Dynamic Programming (overlapping subproblems)
- DFS (similar exploration)
- Branch and Bound (optimization variant)
