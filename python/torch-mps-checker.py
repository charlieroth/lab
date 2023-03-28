import torch

if not torch.backends.mps.is_available():
    if not torch.backends.mps.is_built():
        print("MPS not available because the current PyTorch install was not build with MPS enabled")
    else:
        print("MPS not available because the current MacOS version is not 12.3+"
              "and/or you do not have an MPS-enabled device on this machine")
else:
    mpsd = torch.device("mps")
    x = torch.ones(5, device=mpsd)
    print(x)
    y = x * 2
    print(y)
