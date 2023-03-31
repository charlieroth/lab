import torch

def main():
    mpsd = torch.device("mps")
    x = torch.ones(5, device=mpsd)
    print(x)
    y = x * 2
    print(y)

if __name__ == '__main__':
    main()
