function MatrixSubParam(Zmodel)
%% replcae scalar with scalable matrices
%Vo
syms Vdo Vqo
Vo= sym('Vo', [2 2])
Vo(1,1)=Vdo
Vo(1,2)=Vqo
Vo(2,1)=Vqo
Vo(2,2)=-Vdo
% Io
syms Ido Iqo
Io= sym('Io', [2 2])
Io(1,1)=Ido
Io(1,2)=Iqo
Io(2,1)=-Iqo
Io(2,2)=Ido
% L1
syms s L1 w
ZL1 = sym('ZL1', [2 2])
ZL1(1,1)=s*L1
ZL1(1,2)=-w*L1
ZL1(2,1)=w*L1
ZL1(2,2)=s*L1
% L1w
L1w = sym('L1w', [2 2])
L1w(1,1)=0
L1w(1,2)=-w*L1
L1w(2,1)=w*L1
L1w(2,2)=0
% L2
syms L2
ZL2 = sym('ZL2', [2 2])
ZL2(1,1)=s*L2
ZL2(1,2)=-w*L2
ZL2(2,1)=w*L2
ZL2(2,2)=s*L2
% L2w
L2w = sym('L2w', [2 2])
L2w(1,1)=0
L2w(1,2)=-w*L2
L2w(2,1)=w*L2
L2w(2,2)=0
% C
syms C
ZC = sym('ZC', [2 2])
ZC(1,1)=s*C
ZC(1,2)=-w*C
ZC(2,1)=w*C
ZC(2,2)=s*C
% C
syms Cw
Cw = sym('Cw', [2 2])
Cw(1,1)=0
Cw(1,2)=-w*C
Cw(2,1)=w*C
Cw(2,2)=0
% V
V=inv(eye(2)-L2w*Cw)*(Vo-L2w*Io)
Vd=V(1)
Vq=V(2)
%I
I=inv(eye(2)-L2w*Cw)*(Io-Cw*Vo)
Id=I(1)
Iq=I(2)
% Current Loop
syms KPc KIc
PIC= sym('PIC', [2 2])
PIC(1,1)=KPc+KIc/s
PIC(1,2)=0
PIC(2,1)=0
PIC(2,2)=KPc+KIc/s

% Feed Forward
syms Kvf Tvf
FV= sym('FV', [2 2])
FV(1,1)=Kvf/(1+Tvf*s)
FV(1,2)=0
FV(2,1)=0
FV(2,2)=Kvf/(1+Tvf*s)
% Feed Forward
syms Kvii Tvii
FII= sym('FII', [2 2])
FII(1,1)=Kvii/(1+Tvii*s)
FII(1,2)=0
FII(2,1)=0
FII(2,2)=Kvii/(1+Tvii*s)
% Power Loop
syms KPp KIp KPq KIq 
PIS= sym('PIS', [2 2])
PIS(1,1)=KPp+KIp/s
PIS(1,2)=0
PIS(2,1)=0
PIS(2,2)=-(KPq+KIq)/s
% Voltage Loop
syms KPpV KIpV KPqV KIqV 
PIV= sym('PIV', [2 2])
PIV(1,1)=KPpV+KIpV/s
PIV(1,2)=0
PIV(2,1)=0
PIV(2,2)=-(KPqV+KIqV)/s
% PFilter
syms wc
PFilter= sym('PFilter', [2 2])
PFilter(1,1)=wc/(s+wc)
PFilter(1,2)=0
PFilter(2,1)=0
PFilter(2,2)=wc/(s+wc)
% PLL
syms KPpll KIpll
PLL= sym('PLL', [2 2])
PLL(1,1)=0
PLL(1,2)=0
PLL(2,1)=0
PLL(2,2)=KPpll+KIpll/s
% Droop
syms m n 
Droop= sym('Droop', [2 2])
Droop(1,1)=0
Droop(1,2)=(KIpll/s+KPpll)/m
Droop(2,1)=Vd/(n*sqrt(Vd^2+Vq^2))
Droop(2,2)=Vq/(n*sqrt(Vd^2+Vq^2))
% DroopGFM
syms Df
DroopGFM= sym('DroopGFM', [2 2])
DroopGFM(1,1)=(Df)/s
DroopGFM(1,2)=(Df)/s
DroopGFM(2,1)=0
DroopGFM(2,2)=0
% Synchronvector
syms wnsyn J DDp Kpsyn Kisyn 
SYN= sym('SYN', [2 2])
SYN(1,1)=1/(s*J*wnsyn*(s+(DDp/(J*(1+DDp*(Kisyn/s+Kpsyn))))))    
SYN(1,2)=1/(s*J*wnsyn*(s+(DDp/(J*(1+DDp*(Kisyn/s+Kpsyn))))))
SYN(2,1)=0
SYN(2,2)=0
% Virtual Inertia
syms Dvil
VIL= sym('VIL', [2 2])
VIL(1,1)=1/(s*J*s+Dvil*s)
VIL(1,2)=1/(s*J*s+Dvil*s)
VIL(2,1)=0
VIL(2,2)=0
% Power Synchronization Loop
syms Kpsc
PSC= sym('PSC', [2 2])
PSC(1,1)=Kpsc/(s)
PSC(1,2)=Kpsc/(s)
PSC(2,1)=0
PSC(2,2)=0
% Kdc
syms Vdc Cdc
Kdc= sym('Kdc', [2 2])
Kdc(1,1)=Id/(Cdc*Vdc)
Kdc(1,2)=Iq/(Cdc*Vdc)
Kdc(2,1)=0
Kdc(2,2)=0
% Ydc
Ydc= sym('Ydc', [2 2])
Ydc(1,1)=Vd/(Cdc*Vdc)
Ydc(1,2)=Vq/(Cdc*Vdc)
Ydc(2,1)=0
Ydc(2,2)=0
% DelD
syms tdel Vmax
Deld= sym('Deld', [2 2])
Deld(1,1)=(Vdc/Vmax)*(1-0.5*tdel*s/(1+0.5*tdel*s))
Deld(1,2)=0
Deld(2,1)=0
Deld(2,2)=(Vdc/Vmax)*(1-0.5*tdel*s/(1+0.5*tdel*s))
% DelV
syms D
Delv= sym('Delv', [2 2])
Delv(1,1)=(D/Vmax)*(1-0.5*tdel*s/(1+0.5*tdel*s))
Delv(1,2)=0
Delv(2,1)=0
Delv(2,2)=(D/Vmax)*(1-0.5*tdel*s/(1+0.5*tdel*s))
% Tmain
syms TETA
Tmain= sym('Tmain', [2 2])
Tmain(1,1)=cos(TETA)
Tmain(1,2)=sin(TETA)
Tmain(2,1)=-sin(TETA)
Tmain(2,2)=cos(TETA)
% Tv
Tv= sym('Tv', [2 2])
Tv(1,1)=0
Tv(1,2)=-sin(TETA)*Vd+cos(TETA)*Vq
Tv(2,1)=0
Tv(2,2)=-cos(TETA)*Vd-sin(TETA)*Vq
% TIo
syms Ido Iqo
Tio= sym('Tio', [2 2])
Tio(1,1)=0
Tio(1,2)=-sin(TETA)*Ido+cos(TETA)*Iqo
Tio(2,1)=0
Tio(2,2)=-cos(TETA)*Ido-sin(TETA)*Iqo
%
Ti= sym('Ti', [2 2])
Ti(1,1)=0
Ti(1,2)=-sin(TETA)*Id+cos(TETA)*Iq
Ti(2,1)=0
Ti(2,2)=-cos(TETA)*Id-sin(TETA)*Iq
% Td
Td= sym('Td', [2 2])
Td(1,1)=0
Td(1,2)=-sin(TETA)*D
Td(2,1)=0
Td(2,2)=+cos(TETA)*D
%% load the immpedance equation
GFL_numchar=Zmodel.znumchar
GFL_denchar=Zmodel.zdenchar
eval(['GFL_num=' GFL_numchar])
eval(['GFL_den=' GFL_denchar])
paramnum=symvar(GFL_num)
paramden=symvar(GFL_den)
Param=union_several(paramden,paramnum)
for i=1:length(Param)
param{i}=char(Param(i))
end
%%
GFLModel.numdd=GFL_num(1,1)
GFLModel.numddchar=char(GFLModel.numdd)
GFLModel.dendd=GFL_den(1,1)
GFLModel.denddchar=char(GFLModel.dendd)
%%
GFLModel.numdq=GFL_num(1,2)
GFLModel.numdqchar=char(GFLModel.numdq)
GFLModel.dendq=GFL_den(1,2)
GFLModel.dendqchar=char(GFLModel.dendq)
%%
GFLModel.numqd=GFL_num(2,1)
GFLModel.numqdchar=char(GFLModel.numqd)
GFLModel.denqd=GFL_den(2,1)
GFLModel.denqdchar=char(GFLModel.denqd)
%%
GFLModel.numqq=GFL_num(2,2)
GFLModel.numqqchar=char(GFLModel.numqq)
GFLModel.denqq=GFL_den(2,2)
GFLModel.denqqchar=char(GFLModel.denqq)
%% parameter
for i=1:length(param)
if param{i}=='s'
j=i;
end
end
for i=1:j-1
GFLM.param{i}=char(param(i))
end
for i=j+1:length(param)
GFLM.param{i-1}=char(param(i))
end

%% output
Model.numdd=GFLModel.numddchar
Model.dendd=GFLModel.denddchar
Model.numdq=GFLModel.numdqchar
Model.dendq=GFLModel.dendqchar
Model.numqd=GFLModel.numqdchar
Model.denqd=GFLModel.denqdchar
Model.numqq=GFLModel.numqqchar
Model.denqq=GFLModel.denqqchar
Model.param=GFLM.param
Model.name=Zmodel.name
eval(['Model' Zmodel.name '=Model'])
save(['Model' Zmodel.name], ['Model' Zmodel.name]);
end