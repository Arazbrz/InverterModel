function getresult(X,Y)
root=cd
addpath([root '\functions'])
cd([cd '\Results' X])
load('Out1.mat')
Plottransfer(Out1,Y)
cd(root)
end