% % pitch estimation
% [x2,sr]=wavread('avmA.wav');
% R=yin(x2,sr);
% width=256;
% frameRate=50;
% cor=CorrelogramArray(x2',sr,frameRate,width);
% p1=CorrelogramPitch(cor,width,sr);
% coch=LyonPassiveEar(x2,sr,1,4,.5);
% cor2=CorrelogramArray(coch,sr,frameRate,width);
% p2=CorrelogramPitch(cor2,width,sr);

% sample funciton with a structure
anyName.sr=1000;
inClassFunction2('avm.wav',anyName)
inClassFunction2('avm.wav')
anyName2.minf0=880;
anyName2
inClassFunction2('avm.wav',anyName2)

% correlogram F0 estimation
f0trace=correlogramF0('avm.wav',1,1)
figure(2)
f0trace2=correlogramF0('avm.wav',0,1)