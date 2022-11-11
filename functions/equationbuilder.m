function Zmodel=equationbuilder(Input,name)
% Input.Angle='Droop' 'DroopGFM' 'SYN' 'PSC' 'VIL'
% Input.Filter='LCL' 'L'
% Input.FfC=0,1
% Input.Pfilter=0,1
% Input.Droop=0,1
% Input.DC=0,1
% Input.AngelDif=0,1
% Input.FfV=0,1
% Input.DQV=0,1
% Input.DQIo=0,1
% Input.DQI=0,1
% Input.QDD=0,1



%% variables
syms z
syms vo vop v vp u up ii ip io iop vdc d dp se sref iref T 
%% parameterss
syms ZL1 ZL2 ZC PIC PIV L1w Cw FV FII PIS PFilter V I Droop DroopGFM PSC VIL SYN Ydc Kdc Delv Deld Tmain Tv Tio Ti Td PLL
%% Equations create
% L2 C
if strcmpi(Input.Filter,'LCL')
eq(1)=vo-v==ZL2*io;
eq(2)=io-ii==ZC*v;
else
eq(1)=vo-v==0;
eq(2)=io-ii==0;
end
chareq{1}=char(eq(1))
chareq{2}=char(eq(2))
% L1
eq(3)=u-v==ZL1*ii;
chareq{3}=char(eq(3))
% Current Loop
if Input.FfV==1
eq(4)=dp==PIC*(iref-ip)+L1w*ip+FV*vp;
else
eq(4)=dp==PIC*(iref-ip)+L1w*ip;
end
chareq{4}=char(eq(4))
% Pfilter
if Input.FfC==0
FII=0
end
if Input.Pfilter==0
PFilter=1
end
if Input.AngelDif==0
Tmain=1
end
% Power Loop
if strcmpi(Input.Control,'C')
    eq(5)=iref==PIS*(sref-se);
    eq(6)=se==PFilter*(I*vp+V*iop);
else
    eq(5)=iref==PIV*(-vp)+Cw*vp+FII*ip;
    eq(6)=se==PFilter*(I*vp+V*iop);
end
chareq{5}=char(eq(5))
chareq{6}=char(eq(6))
% Reference Generation
if Input.Droop==1
eq(7)=sref==Droop*vp;
else
eq(7)=sref==0;
end
chareq{7}=char(eq(7))
% DC Dynamics
if Input.DC==1
eq(8)=vdc==Ydc*v+Kdc*io;
else
eq(8)=vdc==0;
end
chareq{8}=char(eq(8))
% PWM
eq(9)=u==Delv*d+Deld*vdc;
chareq{9}=char(eq(9))

% PLL for vp measure
if Input.DQV==0
Tv=0
end
eq(10)=vp==Tmain*v+Tv*T;
chareq{10}=char(eq(10))
% PLL for ip measure
if Input.DQIo==0
Tio=0
end
eq(11)=iop==Tmain*io+Tio*T;
chareq{11}=char(eq(11))
% PLL for i measure
if Input.DQI==0
Ti=0
end
eq(12)=ip==Tmain*ii+Ti*T;
chareq{12}=char(eq(12))
% PLL for qd
if Input.QDD==0
Td=0
end
eq(13)=d==dp/Tmain+Td*T;
chareq{13}=char(eq(13))
% PLL
if strcmpi(Input.Angle,"PLL")
eq(14)=T==PLL*vp;
elseif strcmpi(Input.Angle,"DroopGFM")
eq(14)=T==DroopGFM*PFilter*(I*vp+V*iop);
elseif strcmpi(Input.Angle,"SYN")
eq(14)=T==SYN*PFilter*(I*vp+V*iop);
elseif strcmpi(Input.Angle,"PSC")
eq(14)=T==PSC*PFilter*(I*vp+V*iop);
elseif strcmpi(Input.Angle,"VIL")
eq(14)=T==VIL*PFilter*(I*vp+V*iop);
end
chareq{14}=char(eq(14))
%% Solve preprocess
chareq=chareq'
for i=1:length(chareq)
chareqsubval{i,1}=replaceBetween(chareq{i},1,'=','M','Boundaries','inclusive')
END=length(chareq{i})
chareqsubval{i,2}=eraseBetween(chareq{i}," == ",END,'Boundaries','inclusive')
chareqsubval{i,2}=insertBefore(chareqsubval{i,2},1,'N=')
end
%% solve equations
eval(chareqsubval{1,1})
eval(chareqsubval{1,2})
v=solve(N==M,v)
%
eval(chareqsubval{2,1})
eval(chareqsubval{2,2})
ii=solve(N==M,ii)
%
eval(chareqsubval{10,1})
eval(chareqsubval{10,2})
eq(10)=vp==M;
eval(chareqsubval{11,1})
eval(chareqsubval{11,2})
M1=M
N1=N
eq(11)=M1==N1;
eval(chareqsubval{14,1})
eval(chareqsubval{14,2})
eq(14)=T==M;
An=solve([eq(14) eq(11) eq(10)],vp,T,iop);
vp=An.vp
T=An.T
iop=An.iop
%
eval(chareqsubval{12,1})
eval(chareqsubval{12,2})
M2=M
N2=N
eq(12)=M2==N2;
ip=solve([eq(12)],ip)
%
eval(chareqsubval{7,1})
eval(chareqsubval{7,2})
eq(7)=sref==M;
sref=solve(eq(7),sref)
%
eval(chareqsubval{6,1})
eval(chareqsubval{6,2})
eq(6)=se==M;
se=solve(eq(6),se)
%
eval(chareqsubval{5,1})
eval(chareqsubval{5,2})
eq(5)=iref==M;
iref=solve(eq(5),iref)
%
eval(chareqsubval{4,1})
eval(chareqsubval{4,2})
eq(4)=dp==M;
dp=solve(eq(4),dp)
%
eval(chareqsubval{13,1})
eval(chareqsubval{13,2})
eq(13)=d==M;
d=solve(eq(13),d)
%
eval(chareqsubval{8,1})
eval(chareqsubval{8,2})
eq(8)=vdc==M;
vdc=solve(eq(8),vdc)
%
eval(chareqsubval{9,1})
eval(chareqsubval{9,2})
eq(9)=u==M;
u=solve(eq(9),u)
%
eval(chareqsubval{3,1})
eval(chareqsubval{3,2})
eq(3)=N==M;
vo=solve(eq(3),vo)
% %%
vo=simplify(vo)
z=vo/io
%[gain,z] = polynomialReduce(vo,io)
%% 
Zmodel.zchar=char(z)
[nn dd]=numden(z)
Zmodel.znumchar=char(nn)
Zmodel.zdenchar=char(dd)
Zmodel.input=Input
Zmodel.name=name
end