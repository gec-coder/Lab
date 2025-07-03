# Graph: adjacency list with edge costs
graph = {
    'A': {'B': 5, 'C': 6},
    'B': {'D': 5, 'E': 2},
    'C': {'F': 5},
    'D': {},
    'E': {'F': 1},
    'F': {}
}

# Heuristic values (example: straight-line distance to goal)
heuristic = {
    'A': 7,
    'B': 6,
    'C': 2,
    'D': 5,
    'E': 1,
    'F': 0
}

# Best-First Search
def best_first_search(graph, heuristic, start, goal):
    visited = set()
    queue = [(start, [start])]  # (node, path)

    while queue:
        # Sort by heuristic (smallest first)
        queue.sort(key=lambda x: heuristic[x[0]])
        current, path = queue.pop(0)

        if current == goal:
            print("Best-First Search Path:", " -> ".join(path))
            print(f"Total Heuristic Cost (final h(n)): {heuristic[current]}")
            return

        visited.add(current)

        for neighbor in graph[current]:
            if neighbor not in visited:
                queue.append((neighbor, path + [neighbor]))

    print(f"Goal {goal} not reachable from {start} using Best-First Search.")

# ----- User Interaction -----
print("Available nodes:", list(graph.keys()))
start_node = input("Enter starting node: ").strip().upper()
goal_node = input("Enter goal node: ").strip().upper()

print("\nBest-First Search:")
best_first_search(graph, heuristic, start_node, goal_node)
