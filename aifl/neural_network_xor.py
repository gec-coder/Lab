import numpy as np

# Activation function and its derivative
def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def sigmoid_derivative(x):
    return x * (1 - x)

# XOR input
X = np.array([[0, 0],
              [0, 1],
              [1, 0],
              [1, 1]])

# Expected XOR output
y = np.array([[0],
              [1],
              [1],
              [0]])

# Initialize weights
np.random.seed(42)
weights_0 = 2 * np.random.random((2, 2)) - 1  # Input to hidden layer
weights_1 = 2 * np.random.random((2, 1)) - 1  # Hidden to output layer

# Training parameters
epochs = 20000
learning_rate = 0.1

# Training loop
for epoch in range(epochs):
    # Forward pass
    layer_0 = X
    layer_1 = sigmoid(np.dot(layer_0, weights_0))
    layer_2 = sigmoid(np.dot(layer_1, weights_1))

    # Error and Backpropagation
    layer_2_error = y - layer_2
    layer_2_delta = layer_2_error * sigmoid_derivative(layer_2)

    layer_1_error = layer_2_delta.dot(weights_1.T)
    layer_1_delta = layer_1_error * sigmoid_derivative(layer_1)

    # Update weights
    weights_1 += learning_rate * layer_1.T.dot(layer_2_delta)
    weights_0 += learning_rate * layer_0.T.dot(layer_1_delta)

# Testing phase
print("Enter four sets of binary inputs (0 or 1), one set per line (e.g., 0 1):")
input_data = []
for _ in range(4):
    input_str = input().split()
    input_data.append([int(x) for x in input_str])

# Convert input to array and predict
layer_0 = np.array(input_data)
layer_1 = sigmoid(np.dot(layer_0, weights_0))
layer_2 = sigmoid(np.dot(layer_1, weights_1))

# Output prediction
print("\nPredicted output:")
for i in range(4):
    print(f"Input: {layer_0[i]} -> Predicted Output: {round(layer_2[i][0])}")

# Display weights and structure
print("\nFinal weights after training:")
print("Input to Hidden Layer Weights (weights_0):\n", weights_0)
print("Hidden Layer to Output Weights (weights_1):\n", weights_1)

# Layer information
num_inputs = X.shape[1]
num_hidden = weights_0.shape[1]
num_outputs = 1
print("\nNumber of Layers:")
print("Input Layer:", num_inputs, "neurons")
print("Hidden Layer:", num_hidden, "neurons")
print("Output Layer:", num_outputs, "neurons")
