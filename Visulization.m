clc
clear 
close
%% Plots
root=cd
addpath([root '\functions'])
% pzplot %bode %rlocus %step %nichols %nyquist %impulse
getresult('GFLComplete','impulse')
%getresult('GFLMPSC','bode')
%getresult('GFLMPSC','nichols')
%getresult('GFLMPSC','nyquist')
getsummary('GFLComplete')