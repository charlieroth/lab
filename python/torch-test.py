import torch

def main():
    if torch.cuda.is_available():
        print("cuda is cudaing")

if __name__ == '__main__':
    main()
