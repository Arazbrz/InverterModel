function Out=Modelbuilder(GFLModel,input)
for i=1:length(GFLModel.param)
SS=GFLModel.param{i};
eval([SS '=sym(''' SS ''')'])
eval([SS '=sym(''' SS ''')'])
end
mat={'dd', 'dq', 'qd', 'qq'}
for mm=1:4
s=sym('s')
eval(['x=GFLModel.num' mat{mm}])
eval(['y=GFLModel.den' mat{mm}])
eval(['num' mat{mm} '=' x])
eval(['den' mat{mm} '=' y])
for i=1:length(GFLModel.param)
eval([GFLModel.param{i} '=input.' GFLModel.param{i}])
eval(['num' mat{mm} '=char(num' mat{mm} ')'])
eval(['den' mat{mm} '=char(den' mat{mm} ')'])
eval(['x=num' mat{mm}])
eval(['y=den' mat{mm}])
eval(['num' mat{mm} '=' x])
eval(['den' mat{mm} '=' y])
eval(['num' mat{mm} '=simplify(num' mat{mm} ')'])
eval(['den' mat{mm} '=simplify(den' mat{mm} ')'])
end
eval(['num' mat{mm} '=char(num' mat{mm} ')'])
eval(['den' mat{mm} '=char(den' mat{mm} ')'])
s=tf('s')
eval(['x=num' mat{mm}])
eval(['y=den' mat{mm}])
eval(['den' mat{mm} '=' y])
eval(['num' mat{mm} '=' x])
eval(['Out.Z.' mat{mm} '=num' mat{mm} '/den' mat{mm}])
eval(['Out.Y.' mat{mm} '=den' mat{mm} '/num' mat{mm}])
eval(['Out.N.' mat{mm} '=num' mat{mm}])
eval(['Out.D.' mat{mm} '=den' mat{mm}])
end
Out.name=GFLModel.name
end

