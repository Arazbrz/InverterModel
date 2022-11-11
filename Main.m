clc
close all
clear all
%% Load the handle
root=cd
addpath([root '\functions'])
%% Parameter Selection
%System Parameters
% ( 'C'	'Cdc'	'D'	'Ido'	'Iqo'	'KIc'	'KIp'	'KIpll'	'KIq'	'KPc'	'KPp'	'KPpll'	'KPq'	'Kvf'	'L1'	'L2'	'TETA'	'Tvf'	'Vdo'	'Vmax'	'Vqo'	'm'	'n'	'tdel'	'w'	'wc'
%System
% System Parameters
input.w=2*pi*60;
% Design Parameters
input.L1=0.1;
input.L2=0.1;
input.C=0.5; 
input.Cdc=0.9;
input.D=1;
input.Vmax=1;
input.tdel=1/40000;
%Droop Results
input.m=10e-4;
input.n=3*10e-3;
%Power Flow Results
input.Ido=1;
input.Iqo=0;
input.Vdo=1;
% Operation angle
input.TETA=0.000;
input.Vqo=input.Vdo*tan(input.TETA);
input.Vdc=input.Vdo/input.D;
%% control parameters
% Current Loop
input.KIc=0.1;input.KPc=1;
% Voltage Loop
input.KIqV=1;input.KPqV=1
input.KIpV=1;input.KPpV=1;
% Power Loop
input.KIp=10;input.KPp=100;
input.KIq=10;input.KPq=100;
% Pll Loop
input.KIpll=10000;input.KPpll=100;
% feed forward
input.Kvf=1;input.Tvf=0.02;
input.Kvii=1;input.Tvii=0.04;
% filter
input.wc=10000
% GFM param
input.Kpsc=0.5;
input.Df=10e5
input.DDp=10e5;
input.J=2*10e3;
input.Kisyn=1;%10
input.Kpsyn=1;%100
input.wnsyn=2*pi*60;
input.Dvil=10;
%% Load and Derive Transfer Function
ModeltrBuild('GFLComplete',input)
