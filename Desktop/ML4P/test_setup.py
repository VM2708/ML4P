import torch
print(f"PyTorch version: {torch.__version__}")
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"You're all set! Nice Work!")

dtype = torch.float
x = torch.linspace(-1, 1, 2000, dtype=dtype)
f = torch.cos(7*x)**2 * torch.exp(-1*x)

'''
git remote add ml4p https://github.com/VM2708/ML4P.git
git branch -M main
git push -u ml4p main
'''
