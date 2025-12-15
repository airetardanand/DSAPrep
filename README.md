# DSAPrep - Data Structures and Algorithms Comprehensive Guide

Welcome to **DSAPrep**, your ultimate resource for mastering Data Structures and Algorithms! This repository contains detailed explanations, implementations, and examples of 30 essential DSA patterns that will help you excel in coding interviews and real-world problem-solving.

## 📚 Table of Contents

1. [Overview](#overview)
2. [30 DSA Patterns](#30-dsa-patterns)
3. [How to Use This Repository](#how-to-use-this-repository)
4. [Contributing](#contributing)
5. [License](#license)

---

## 🎯 Overview

This repository is organized around **30 fundamental Data Structures and Algorithms patterns** that appear frequently in:
- Technical interviews at FAANG companies
- Competitive programming contests
- Real-world software development
- LeetCode and other coding challenge platforms

Each pattern includes:
- 📖 Detailed explanation and theory
- 💻 Multiple implementations (Python, Java, C++)
- 📊 Time and Space Complexity analysis
- 🔗 Related problems and variations
- ⚡ Practical tips and tricks

---

## 30 DSA Patterns

### **Core Data Structures**

#### 1. **Array & String Manipulation**
- **What it covers**: Array traversal, searching, sorting, string operations
- **Key techniques**: Two pointers, sliding window, prefix sums
- **Common problems**: Container with Most Water, Trapping Rain Water
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 2. **Linked List Operations**
- **What it covers**: Node creation, traversal, insertion, deletion, reversal
- **Key techniques**: Fast/slow pointers, dummy nodes, reversing
- **Common problems**: Reverse Linked List, Merge Sorted Lists
- **Difficulty**: ⭐⭐⭐ (Medium)

#### 3. **Stack & Queue**
- **What it covers**: LIFO/FIFO operations, monotonic stacks, deques
- **Key techniques**: Stack for DFS-like problems, queue for BFS
- **Common problems**: Valid Parentheses, Daily Temperatures
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 4. **Hash Table & Hash Set**
- **What it covers**: Hash maps, hash sets, collision handling
- **Key techniques**: Frequency counting, caching, lookup optimization
- **Common problems**: Two Sum, Valid Anagram
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 5. **Tree Basics**
- **What it covers**: Binary trees, BSTs, tree traversal
- **Key techniques**: Inorder, preorder, postorder, level-order traversal
- **Common problems**: Invert Binary Tree, Maximum Path Sum
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 6. **Heap & Priority Queue**
- **What it covers**: Min/max heaps, heap operations, heap sort
- **Key techniques**: Heapify, top-k problems, median finding
- **Common problems**: Kth Largest Element, Merge K Sorted Lists
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 7. **Graph Representation**
- **What it covers**: Adjacency list, adjacency matrix, graph types
- **Key techniques**: Graph construction, edge representation
- **Common problems**: Graph initialization, representation selection
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 8. **Trie (Prefix Tree)**
- **What it covers**: Trie construction, insertion, search, deletion
- **Key techniques**: DFS traversal of trie, prefix-based queries
- **Common problems**: Longest Common Prefix, Word Search II
- **Difficulty**: ⭐⭐⭐ (Medium)

---

### **Search & Traversal Algorithms**

#### 9. **Breadth-First Search (BFS)**
- **What it covers**: Level-order traversal, shortest path in unweighted graphs
- **Key techniques**: Queue-based iteration, visited set tracking
- **Common problems**: Level Order Traversal, Shortest Path
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 10. **Depth-First Search (DFS)**
- **What it covers**: Graph and tree exploration, backtracking foundation
- **Key techniques**: Recursive traversal, stack-based iteration
- **Common problems**: Number of Islands, Clone Graph
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 11. **Binary Search**
- **What it covers**: Sorted array searching, search space optimization
- **Key techniques**: Left/right pointers, mid calculations, boundary conditions
- **Common problems**: Search in Rotated Array, Find First/Last Position
- **Difficulty**: ⭐⭐⭐ (Medium)

#### 12. **Two Pointers**
- **What it covers**: Convergent pointers, same-direction pointers
- **Key techniques**: Moving both pointers toward each other or same direction
- **Common problems**: 3Sum, Container with Most Water
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 13. **Sliding Window**
- **What it covers**: Fixed and dynamic window problems
- **Key techniques**: Window expansion/contraction, hash map for tracking
- **Common problems**: Longest Substring Without Repeating Characters, Permutation in String
- **Difficulty**: ⭐⭐ (Easy to Medium)

---

### **Optimization Algorithms**

#### 14. **Dynamic Programming (DP) - 1D**
- **What it covers**: Linear DP, sequence problems
- **Key techniques**: Memoization, bottom-up DP, space optimization
- **Common problems**: House Robber, Climbing Stairs
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 15. **Dynamic Programming (DP) - 2D**
- **What it covers**: Matrix DP, path counting, string matching
- **Key techniques**: 2D DP tables, space optimization to 1D
- **Common problems**: Unique Paths, Edit Distance
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 16. **Greedy Algorithms**
- **What it covers**: Greedy choice property, optimization problems
- **Key techniques**: Making locally optimal choices, proof of correctness
- **Common problems**: Jump Game, Activity Selection
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 17. **Recursion & Backtracking**
- **What it covers**: Recursive problem solving, constraint satisfaction
- **Key techniques**: Base cases, recursive calls, state restoration
- **Common problems**: N-Queens, Permutations, Combinations
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

---

### **Graph Algorithms**

#### 18. **Topological Sort**
- **What it covers**: DAG ordering, dependency resolution
- **Key techniques**: Kahn's algorithm, DFS-based approach
- **Common problems**: Course Schedule, Alien Dictionary
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 19. **Dijkstra's Algorithm**
- **What it covers**: Single-source shortest path, non-negative weights
- **Key techniques**: Priority queue, relaxation, visited tracking
- **Common problems**: Network Delay Time, Path with Maximum Minimum Value
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 20. **Bellman-Ford Algorithm**
- **What it covers**: Shortest path with negative weights, negative cycle detection
- **Key techniques**: Relaxation iterations, cycle detection
- **Common problems**: Cheapest Flights Within K Stops
- **Difficulty**: ⭐⭐⭐ (Hard)

#### 21. **Floyd-Warshall Algorithm**
- **What it covers**: All-pairs shortest path, transitive closure
- **Key techniques**: DP approach, intermediate vertices
- **Common problems**: Network Connectivity, City Connectivity Matrix
- **Difficulty**: ⭐⭐⭐ (Hard)

#### 22. **Minimum Spanning Tree (MST) - Kruskal's**
- **What it covers**: MST construction using edge sorting and Union-Find
- **Key techniques**: Union-Find data structure, edge weight sorting
- **Common problems**: Connecting Cities with Minimum Cost
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 23. **Minimum Spanning Tree (MST) - Prim's**
- **What it covers**: MST construction using vertex expansion
- **Key techniques**: Priority queue, adjacent vertex tracking
- **Common problems**: Minimum Cost to Connect All Points
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

---

### **Advanced Techniques**

#### 24. **Binary Indexed Tree (Fenwick Tree)**
- **What it covers**: Range sum queries, efficient updates
- **Key techniques**: Bit manipulation for index calculation, prefix sum optimization
- **Common problems**: Range Sum Query, Inversion Count
- **Difficulty**: ⭐⭐⭐⭐ (Hard)

#### 25. **Segment Tree**
- **What it covers**: Range queries, interval updates, lazy propagation
- **Key techniques**: Tree construction, recursive queries/updates
- **Common problems**: Range Maximum Query, Range Update
- **Difficulty**: ⭐⭐⭐⭐ (Hard)

#### 26. **Union-Find (Disjoint Set Union)**
- **What it covers**: Set membership, connected components, cycle detection
- **Key techniques**: Path compression, union by rank
- **Common problems**: Number of Islands II, Accounts Merge
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 27. **Bit Manipulation**
- **What it covers**: Bitwise operations, power of 2, single number problems
- **Key techniques**: AND, OR, XOR operations, bit shifting
- **Common problems**: Single Number, Number of 1 Bits
- **Difficulty**: ⭐⭐ (Easy to Medium)

#### 28. **Math Algorithms**
- **What it covers**: Number theory, GCD, modular arithmetic, prime numbers
- **Key techniques**: Euclidean algorithm, Sieve of Eratosthenes
- **Common problems**: Power of Three, Valid Perfect Square
- **Difficulty**: ⭐⭐ (Easy to Medium)

---

### **String & Advanced Patterns**

#### 29. **Knuth-Morris-Pratt (KMP) Algorithm**
- **What it covers**: Pattern matching, string searching
- **Key techniques**: Failure function, linear time matching
- **Common problems**: Implement strStr(), Shortest Palindrome
- **Difficulty**: ⭐⭐⭐ (Medium to Hard)

#### 30. **Interval Scheduling & Merging**
- **What it covers**: Interval problems, merging overlapping intervals
- **Key techniques**: Sorting, greedy selection, interval comparison
- **Common problems**: Merge Intervals, Meeting Rooms
- **Difficulty**: ⭐⭐⭐ (Medium)

---

## 📊 Pattern Difficulty & Frequency Chart

| Category | Pattern | Difficulty | Interview Frequency |
|----------|---------|-----------|-------------------|
| Fundamentals | Array & String | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| Fundamentals | Linked List | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Fundamentals | Stack & Queue | ⭐⭐ | ⭐⭐⭐⭐ |
| Fundamentals | Hash Table | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| Fundamentals | Tree Basics | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| Fundamentals | Heap | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Fundamentals | Graph Representation | ⭐⭐ | ⭐⭐⭐⭐ |
| Fundamentals | Trie | ⭐⭐⭐ | ⭐⭐⭐ |
| Search | BFS | ⭐⭐ | ⭐⭐⭐⭐ |
| Search | DFS | ⭐⭐ | ⭐⭐⭐⭐ |
| Search | Binary Search | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Search | Two Pointers | ⭐⭐ | ⭐⭐⭐⭐ |
| Search | Sliding Window | ⭐⭐ | ⭐⭐⭐⭐ |
| Optimization | DP - 1D | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Optimization | DP - 2D | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Optimization | Greedy | ⭐⭐⭐ | ⭐⭐⭐ |
| Optimization | Recursion & Backtracking | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| Graph | Topological Sort | ⭐⭐⭐ | ⭐⭐⭐ |
| Graph | Dijkstra | ⭐⭐⭐ | ⭐⭐⭐ |
| Graph | Bellman-Ford | ⭐⭐⭐ | ⭐⭐ |
| Graph | Floyd-Warshall | ⭐⭐⭐ | ⭐⭐ |
| Graph | Kruskal's MST | ⭐⭐⭐ | ⭐⭐⭐ |
| Graph | Prim's MST | ⭐⭐⭐ | ⭐⭐⭐ |
| Advanced | Fenwick Tree | ⭐⭐⭐⭐ | ⭐⭐ |
| Advanced | Segment Tree | ⭐⭐⭐⭐ | ⭐⭐ |
| Advanced | Union-Find | ⭐⭐⭐ | ⭐⭐⭐ |
| Advanced | Bit Manipulation | ⭐⭐ | ⭐⭐⭐ |
| Advanced | Math Algorithms | ⭐⭐ | ⭐⭐⭐ |
| String | KMP Algorithm | ⭐⭐⭐ | ⭐⭐ |
| String | Interval Scheduling | ⭐⭐⭐ | ⭐⭐⭐ |

---

## 🚀 How to Use This Repository

### 1. **Getting Started**
```bash
git clone https://github.com/airetardanand/DSAPrep.git
cd DSAPrep
```

### 2. **Structure**
```
DSAPrep/
├── README.md                 # This file
├── 01-Array-String/         # Array and String patterns
├── 02-LinkedList/           # Linked List implementations
├── 03-Stack-Queue/          # Stack and Queue patterns
├── 04-Hash-Table/           # Hash Table and Set problems
├── 05-Trees/                # Tree data structures
├── 06-Heap/                 # Heap and Priority Queue
├── 07-Graphs/               # Graph representations
├── 08-Trie/                 # Trie data structure
├── 09-BFS-DFS/              # Breadth-first and Depth-first search
├── 10-Binary-Search/        # Binary Search patterns
├── 11-Two-Pointers/         # Two Pointers technique
├── 12-Sliding-Window/       # Sliding Window technique
├── 13-DP-1D/                # 1D Dynamic Programming
├── 14-DP-2D/                # 2D Dynamic Programming
├── 15-Greedy/               # Greedy Algorithms
├── 16-Backtracking/         # Recursion and Backtracking
├── 17-Topological-Sort/     # Topological Sorting
├── 18-Dijkstra/             # Dijkstra's Algorithm
├── 19-Bellman-Ford/         # Bellman-Ford Algorithm
├── 20-Floyd-Warshall/       # Floyd-Warshall Algorithm
├── 21-Kruskal-MST/          # Kruskal's MST
├── 22-Prim-MST/             # Prim's MST
├── 23-Fenwick-Tree/         # Binary Indexed Tree
├── 24-Segment-Tree/         # Segment Tree
├── 25-Union-Find/           # Union-Find (DSU)
├── 26-Bit-Manipulation/     # Bit Manipulation
├── 27-Math-Algorithms/      # Mathematical Algorithms
├── 28-KMP-Algorithm/        # KMP String Matching
├── 29-Interval-Scheduling/  # Interval Problems
└── 30-Advanced-Problems/    # Mixed pattern problems
```

### 3. **Learning Path**

**Beginner (Weeks 1-4):**
- Array & String Manipulation
- Linked List Operations
- Stack & Queue
- Hash Table & Hash Set

**Intermediate (Weeks 5-8):**
- Tree Basics
- Heap & Priority Queue
- BFS & DFS
- Binary Search
- Two Pointers
- Sliding Window

**Advanced (Weeks 9-12):**
- Dynamic Programming (1D & 2D)
- Greedy Algorithms
- Recursion & Backtracking
- Graph Algorithms (Topological Sort, Dijkstra, etc.)

**Expert (Weeks 13-16):**
- Advanced Data Structures (Fenwick Tree, Segment Tree)
- Union-Find
- KMP Algorithm
- Bit Manipulation
- Math Algorithms
- Mixed Pattern Problems

### 4. **Each Pattern Includes**
- 📝 **Concept Explanation**: Clear theory and intuition
- 💡 **Key Insights**: Critical tips for interviews
- 🔍 **Common Pitfalls**: What to watch out for
- ⏱️ **Time & Space Complexity**: Big O analysis
- 💻 **Code Implementations**: Multiple programming languages
- 🧪 **Test Cases**: Example inputs and expected outputs
- 🔗 **Related Problems**: Similar and variant problems
- 🎯 **Interview Tips**: Strategies for technical interviews

---

## 📈 Progress Tracking

Create a personal checklist as you master each pattern:

- [ ] Array & String
- [ ] Linked List
- [ ] Stack & Queue
- [ ] Hash Table
- [ ] Tree Basics
- [ ] Heap
- [ ] Graph Representation
- [ ] Trie
- [ ] BFS
- [ ] DFS
- [ ] Binary Search
- [ ] Two Pointers
- [ ] Sliding Window
- [ ] DP - 1D
- [ ] DP - 2D
- [ ] Greedy
- [ ] Backtracking
- [ ] Topological Sort
- [ ] Dijkstra
- [ ] Bellman-Ford
- [ ] Floyd-Warshall
- [ ] Kruskal's MST
- [ ] Prim's MST
- [ ] Fenwick Tree
- [ ] Segment Tree
- [ ] Union-Find
- [ ] Bit Manipulation
- [ ] Math Algorithms
- [ ] KMP
- [ ] Interval Scheduling

---

## 🎯 Practice Resources

### Recommended Platforms
- **LeetCode**: https://leetcode.com
- **HackerRank**: https://www.hackerrank.com
- **CodeForces**: https://codeforces.com
- **InterviewBit**: https://www.interviewbit.com
- **GeeksforGeeks**: https://www.geeksforgeeks.org

### Books
- "Cracking the Coding Interview" by Gayle Laakmann McDowell
- "Introduction to Algorithms" by CLRS
- "Algorithm Design Manual" by Steven Skiena
- "Competitive Programming" by Steven Halim

---

## 💡 Tips for Success

1. **Understand, Don't Memorize**: Focus on understanding the logic behind each algorithm
2. **Code from Scratch**: Implement solutions without looking at reference code
3. **Analyze Complexity**: Always calculate time and space complexity
4. **Practice Variations**: Solve multiple variations of each pattern
5. **Teach Others**: Explaining concepts solidifies your understanding
6. **Mock Interviews**: Practice with peers to simulate real interview conditions
7. **Review Mistakes**: Spend time understanding why you failed certain problems
8. **Consistency**: Practice daily, even if it's just 30 minutes

---

## 🤝 Contributing

Contributions are welcome! If you'd like to add:
- Better explanations
- Additional code implementations
- More problem examples
- Interview tips and tricks
- Bug fixes or improvements

Please follow these steps:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -m 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙋 Questions & Discussions

Have questions about any pattern? Open an issue or start a discussion!

---

## ✨ Acknowledgments

This repository is created to help aspiring developers and students master Data Structures and Algorithms for interview preparation and competitive programming.

---

## 📞 Contact

Feel free to reach out:
- **GitHub**: [@airetardanand](https://github.com/airetardanand)
- **Issues**: Open an issue for any questions or suggestions

---

**Last Updated**: December 15, 2025

**Happy Coding! 🚀**

---

### Quick Links to Patterns
- [1-8: Core Data Structures](#core-data-structures)
- [9-13: Search & Traversal](#search--traversal-algorithms)
- [14-17: Optimization](#optimization-algorithms)
- [18-23: Graph Algorithms](#graph-algorithms)
- [24-30: Advanced Techniques](#advanced-techniques)
