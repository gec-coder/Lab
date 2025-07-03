# Graph with edge costs
graph = {
    'A': {'B': 2, 'C': 3},
    'B': {'D': 4, 'E': 1},
    'C': {'F': 5},
    'D': {},
    'E': {'F': 1},
    'F': {}
}

# Heuristic values (h(n): estimated cost to reach goal 'F')
heuristic = {
    'A': 7,
    'B': 6,
    'C': 2,
    'D': 5,
    'E': 1,
    'F': 0
}

# A* Search Algorithm
def a_star(graph, heuristic, start, goal):
    open_list = [(start, [start], 0)]  # (node, path, g(n))
    visited = set()

    while open_list:
        # Sort based on f(n) = g(n) + h(n)
        open_list.sort(key=lambda x: x[2] + heuristic[x[0]])
        current_node, path, cost_so_far = open_list.pop(0)

        if current_node == goal:
            print("A* Path:", " -> ".join(path))
            print(f"Total A* Path Cost: {cost_so_far}")
            return

        visited.add(current_node)

        for neighbor, edge_cost in graph[current_node].items():
            if neighbor not in visited:
                total_cost = cost_so_far + edge_cost
                open_list.append((neighbor, path + [neighbor], total_cost))

    print(f"Goal {goal} not reachable from {start} using A* Search.")

# ----- User Interaction -----
print("Available nodes:", list(graph.keys()))
start_node = input("Enter starting node: ").strip().upper()
goal_node = input("Enter goal node: ").strip().upper()

print("\nA* Search:")
a_star(graph, heuristic, start_node, goal_node)
