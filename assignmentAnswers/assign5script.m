[x,sr]=wavread('avm.wav');
yinVals=yin(x,sr);
labels=load('avm-fixed.txt');
load 'loudness.mat'

for i = 1 : size(labels,1)
    
    idx=round(labels(i,1)*sr/32):round(labels(i,2)*sr/32);
    t=(((1:length(yinVals.f0(idx)))/yinVals.sr*yinVals.hop));
    subplot(4,size(labels,1),1+i-1)
    plot(t,2.^yinVals.f0(idx)*440)
    xlim([0 t(end)])   
    ylim([330 660])
    title(sprintf('YIN F0 - Note %d', i))
    
    subplot(4,size(labels,1),7+i-1)
    plot(t,sqrt(yinVals.pwr(idx)))  
    xlim([0 t(end)])    
    ylim([0 0.25])
    title(sprintf('YIN Sqrt(Pwr) - Note %d', i))
    
    subplot(4,size(labels,1),13+i-1)
    plot(loudnessStructure_TV_Zwicker{i}.time,loudnessStructure_TV_Zwicker{i}.InstantaneousLoudness)      
    xlim([0 t(end)])
    ylim([0 35])
    title(sprintf('Zwicker - Note %d', i))

    subplot(4,size(labels,1),19+i-1)
    plot(loudnessStructure_TV_Moore{i}.time, loudnessStructure_TV_Moore{i}.InstantaneousLoudness)
    xlim([0 t(end)])
    ylim([0 35])
    title(sprintf('Moore - Note %d', i))
   
end