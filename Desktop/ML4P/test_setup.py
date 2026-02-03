
import torch
import numpy as np
import matplotlib.pyplot as plt
'''
print(f"PyTorch version: {torch.__version__}")
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"You're all set! Nice Work!")
'''

# compute the derivative of the function with multiple values
#y = 
# compute the derivative of the function with multiple values
x = torch.linspace(1, 10, 100, requires_grad = True)
y = torch.cos(7*x)**2 * torch.exp(-1*x)
torch.sum(y).backward()
a = x.detach().numpy()
print(a)
computed = -1*np.exp(-1*a)*(14*np.cos(7*a)*np.sin(7*a) + (np.cos(7*a))**2)

# ploting the function and derivative
function_line, = plt.plot(x.detach().numpy(), y.detach().numpy(), label = 'Function')
function_line.set_color("red")
derivative_line, = plt.plot(x.detach().numpy(), x.grad.detach().numpy(), label = 'Pytorch Derivative')
derivative_line.set_color("green")
computer_line, = plt.plot(a, computed+0.5, label = 'By Hand Derivative')
computer_line.set_color("blue")
plt.xlabel('x')
plt.legend()
plt.show()



# Need to learn how to use autodiff... maybe a later problem tbh


'''
conda activate torch_clean
cd Desktop/ML4P

git remote add ml4p https://github.com/VM2708/ML4P.git

git branch -M main
git add -m "with code for autodiff"
git push -u ml4p main
'''
