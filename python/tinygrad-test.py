from tinygrad.tensor import Tensor

N = 1024
a, b = Tensor.rand(N, N), Tensor.rand(N, N)
c = a.reshape(N, 1, N) * b.permute(1,0).reshape(1, N, N).sum(axis=2)
d = (c.numpy() - (a.numpy() @ b.numpy())).mean()
print(d)

# x = Tensor.eye(3, requires_grad=True)
# y = Tensor([[2.0,0,-2.0]], requires_grad=True)
# z = y.matmul(x).sum()
# z.backward()
# print(x.grad.numpy())
# print(y.grad.numpy())