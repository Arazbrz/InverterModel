clc
clear all
close all
root=cd
root=erase(root,'\Inverters')
addpath([root '\functions'])
cd([root, '\Inverters'])
%% Inputs
 Input.Angle='PLL'
 Input.Filter='LCL'
 Input.FfC=1
 Input.Pfilter=0
 Input.Droop=0
 Input.DC=0
 Input.AngelDif=1
 Input.FfV=1
 Input.DQV=0
 Input.DQIo=0
 Input.DQI=0
 Input.QDD=0
%% Build Model
name=mfilename
Zmodel=equationbuilder(Input,name)
eval(['Input' name '=Input'])
save(['Input' name], ['Input' name]);
eval(['Zmodel' name '=Zmodel'])
save(['Zmodel' name], ['Zmodel' name]);
%% Make Matrix 2x2
eval(['MatrixSubParam(Zmodel' name ')' ])
cd(root)