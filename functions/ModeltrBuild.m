function ModeltrBuild(X,input)
root=cd
addpath([root '\Inverters'])
addpath([root '\functions'])
load(['Model' X '.mat'])
eval(['Out1=Modelbuilder(Model' X ',input)'])
%load('ModelGFLPaper.mat')
%Out{3,1}=Modelbuilder(ModelGFLPaper,input)
%Out{3,2}=ModelGFLPaper.name
% load('ModelGFLMSyn.mat')
% Out{1,1}=Modelbuilder(ModelGFLMSyn,input)
% Out{1,2}=ModelGFLMSyn.name
%load('ModelGFL.mat')
%Out{1,1}=Modelbuilder(ModelGFL,input)
%Out{1,2}=ModelGFL.name
%load('ModelGFLMVIL.mat')
%Out{1,1}=Modelbuilder(ModelGFLMVIL,input)
%Out{1,2}=ModelGFLMVIL.name
%%
root=cd
    mkdir([root '\Results' Out1.name    ])
    cd([root '\Results' Out1.name    ])
    save('Out1')
    cd(root)
end