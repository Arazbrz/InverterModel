function plotsummary(X)
Summary(3:length(pole(X.Y.dd))+2,2)=real(pole(X.Y.dd))
Summary(3:length(pole(X.Y.dq))+2,4)=real(pole(X.Y.dq))
Summary(3:length(pole(X.Y.qd))+2,6)=real(pole(X.Y.qd))
Summary(3:length(pole(X.Y.qq))+2,8)=real(pole(X.Y.qq))
Summary(3:length(pole(X.Z.dd))+2,10)=real(pole(X.Z.dd))
Summary(3:length(pole(X.Z.dq))+2,12)=real(pole(X.Z.dq))
Summary(3:length(pole(X.Z.qd))+2,14)=real(pole(X.Z.qd))
Summary(3:length(pole(X.Z.qq))+2,16)=real(pole(X.Z.qq))
%
Summary(3:length(pole(X.Y.dd))+2,3)=imag(pole(X.Y.dd))
Summary(3:length(pole(X.Y.dq))+2,5)=imag(pole(X.Y.dq))
Summary(3:length(pole(X.Y.qd))+2,7)=imag(pole(X.Y.qd))
Summary(3:length(pole(X.Y.qq))+2,9)=imag(pole(X.Y.qq))
Summary(3:length(pole(X.Z.dd))+2,11)=imag(pole(X.Z.dd))
Summary(3:length(pole(X.Z.dq))+2,13)=imag(pole(X.Z.dq))
Summary(3:length(pole(X.Z.qd))+2,15)=imag(pole(X.Z.qd))
Summary(3:length(pole(X.Z.qq))+2,17 ...
    )=imag(pole(X.Z.qq))
%
Summary=string(Summary)
%Summary=num2str(Summary)
Summary=num2cell(Summary)
%
Summary{2,2}=length(pole(X.Y.dd))
Summary{2,4}=length(pole(X.Y.dq))
Summary{2,6}=length(pole(X.Y.qd))
Summary{2,8}=length(pole(X.Y.qq))
Summary{2,10}=length(pole(X.Z.dd))
Summary{2,12}=length(pole(X.Z.dq))
Summary{2,14}=length(pole(X.Z.qd))
Summary{2,16}=length(pole(X.Z.qq))
%
Summary{2,3}=''
Summary{2,5}=''
Summary{2,7}=''
Summary{2,9}=''
Summary{2,11}=''
Summary{2,13}=''
Summary{2,15}=''
Summary{2,17}=''
%
Summary{1,2}='Ydd R'
Summary{1,4}='Ydq R'
Summary{1,6}='Yqd R'
Summary{1,8}='Yqq R'
Summary{1,10}='Zdd R'
Summary{1,12}='Zdq R'
Summary{1,14}='Zqd R'
Summary{1,16}='Zqq R'
%
Summary{1,3}='Ydd I'
Summary{1,5}='Ydq I'
Summary{1,7}='Yqd I'
Summary{1,9}='Yqq I'
Summary{1,11}='Zdd I'
Summary{1,13}='Zdq I'
Summary{1,15}='Zqd I'
Summary{1,17}='Zqq I'
for i=1:length(Summary)
Summary{i,1}=''
end
save('Summary.mat')
xlswrite('Summary',Summary)
end