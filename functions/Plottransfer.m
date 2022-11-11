function Plottransfer(Out1,X)
close all
f(1,1)=figure
%sgtitle({[X ' Z Response: ']; Out1.name})
subplot(2,2,1)
try
      eval([X '(Out1.Z.dd)'])
catch
      plot(1:100,1:100)
end
title('Zdd')
subplot(2,2,2)
try
eval([X '(Out1.Z.dq)'])
catch
    plot(1:100,1:100)
end
title('Zqd')
subplot(2,2,3)
try
eval([X '(Out1.Z.qd)'])
catch
    plot(1:100,1:100)
end
title('Zdq')
subplot(2,2,4)
try
eval([X '(Out1.Z.qq)'])
catch
    plot(1:100,1:100)
end
title('Zqq')
set(gcf, 'Name', 'Zplot')
%%
f(1,2)=figure
%sgtitle({[X ' Y Response: ']; Out1.name})
subplot(2,2,1)
try
      eval([X '(Out1.Y.dd)'])
catch
      plot(1:100,1:100)
end
title('Ydd')
subplot(2,2,2)
try
eval([X '(Out1.Y.dq)'])
catch
    plot(1:100,1:100)
end
title('Yqd')
subplot(2,2,3)
try
eval([X '(Out1.Y.qd)'])
catch
    plot(1:100,1:100)
end
title('Ydq')
subplot(2,2,4)
try
eval([X '(Out1.Y.qq)'])
catch
    plot(1:100,1:100)
end
title('Yqq')
set(gcf, 'Name', 'Yplot')
%%
saveas(f(1,1),[X 'Z' Out1.name '.emf'])
saveas(f(1,1),[X 'Z' Out1.name '.jpeg'])
saveas(f(1,1),[X 'Z' Out1.name '.pdf'])
savefig(f(1,1),[X 'Z' Out1.name])
%
saveas(f(1,2),[X 'Y' Out1.name '.emf'])
saveas(f(1,2),[X 'Y' Out1.name '.jpeg'])
saveas(f(1,2),[X 'Y' Out1.name '.pdf'])
savefig(f(1,2),[X 'Y' Out1.name])
end