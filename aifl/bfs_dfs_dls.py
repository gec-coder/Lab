# Graph with edge costs
graph = {
    'A': {'B': 2, 'C': 3},
    'B': {'D': 4, 'E': 1},
    'C': {'F': 5},
    'D': {},
    'E': {'F': 1},
    'F': {}
}

# 1. Breadth-First Search (BFS) to goal
def bfs(graph, start, goal):
    visited = set()
    queue = [(start, [start], 0)]  # (node, path, cost)

    while queue:
        node, path, cost = queue.pop(0)
        if node == goal:
            print("BFS Path:", " -> ".join(path))
            print(f"Total BFS Cost: {cost}")
            return
        if node not in visited:
            visited.add(node)
            for neighbor, edge_cost in graph[node].items():
                if neighbor not in visited:
                    queue.append((neighbor, path + [neighbor], cost + edge_cost))
    
    print(f"Goal {goal} not reachable from {start} using BFS.")

# 2. Depth-First Search (DFS) to goal
def dfs(graph, node, goal, visited=None, path=None, cost=0):
    if visited is None:
        visited = set()
    if path is None:
        path = []

    path.append(node)
    visited.add(node)

    if node == goal:
        print("DFS Path:", " -> ".join(path))
        print(f"Total DFS Cost: {cost}")
        return True

    for neighbor, edge_cost in graph[node].items():
        if neighbor not in visited:
            if dfs(graph, neighbor, goal, visited, path, cost + edge_cost):
                return True

    path.pop()
    return False

# 3. Depth-Limited Search (DLS) to goal
def dls(graph, node, goal, limit, cost=0, path=None):
    if path is None:
        path = []

    path.append(node)

    if node == goal:
        print("DLS Path:", " -> ".join(path))
        print(f"Total DLS Cost: {cost}")
        return True

    if limit <= 0:
        path.pop()
        return False

    for neighbor, edge_cost in graph[node].items():
        if dls(graph, neighbor, goal, limit - 1, cost + edge_cost, path):
            return True

    path.pop()
    return False

# ----- User Interaction -----
print("Available nodes:", list(graph.keys()))
start_node = input("Enter starting node: ").strip().upper()
goal_node = input("Enter goal node: ").strip().upper()
limit = int(input("Enter depth limit (for DLS): "))

print("\n1. Breadth-First Search:")
bfs(graph, start_node, goal_node)

print("\n2. Depth-First Search:")
found_dfs = dfs(graph, start_node, goal_node)
if not found_dfs:
    print(f"Goal {goal_node} not reachable from {start_node} using DFS.")

print(f"\n3. Depth-Limited Search (limit = {limit}):")
found_dls = dls(graph, start_node, goal_node, limit)
if not found_dls:
    print(f"Goal {goal_node} not reachable from {start_node} within depth limit {limit} using DLS.")
