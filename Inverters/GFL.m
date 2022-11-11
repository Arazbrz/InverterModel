clc
clear all
close all
root=cd
root=erase(root,'\Inverters')
addpath([root '\functions'])
%% Inputs
 Input.Angle='PLL'
 Input.Filter='LCL'
 Input.FfC=1
 Input.Pfilter=1
 Input.Droop=1
 Input.DC=1
 Input.AngelDif=1
 Input.FfV=1
 Input.DQV=1
 Input.DQIo=1
 Input.DQI=1
 Input.QDD=1
%% Build Model
name=mfilename
Zmodel=equationbuilder(Input,name)
eval(['Input' name '=Input'])
save(['Input' name], ['Input' name]);
eval(['Zmodel' name '=Zmodel'])
save(['Zmodel' name], ['Zmodel' name]);
%% Make Matrix 2x2
eval(['MatrixSubParam(Zmodel' name ')' ])