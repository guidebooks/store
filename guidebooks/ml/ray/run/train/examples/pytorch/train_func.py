import torch.optim as optim

def train_func():
    num_epochs = 3
    model = NeuralNetwork()
    loss_fn = nn.MSELoss()
    optimizer = optim.SGD(model.parameters(), lr=0.1)

    for epoch in range(num_epochs):
        output = model(input)
        loss = loss_fn(output, labels)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
        print(f"epoch: {epoch}, loss: {loss.item()}")
