function f0trace=correlogramF0(filename,cochlearSwitch,plotSwitch)

[x,sr]=wavread(filename);

if cochlearSwitch
    coch=LyonPassiveEar(x,sr,1,4,.5);
    cor=CorrelogramArray(coch,sr,50,256);
else
    cor=CorrelogramArray(x',sr);
end

f0trace=CorrelogramPitch(cor,256,sr);

if plotSwitch
    plot(f0trace)
end