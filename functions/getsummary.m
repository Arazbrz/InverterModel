function getsummary(X)
root=cd
addpath([root '\functions'])
cd([cd '\Results' X])
load('Out1.mat')
plotsummary(Out1)
cd(root)
end