% summarizing loudness data
load loudness.mat
% subplot(211), plot(loudnessStructure_TV_Moore{1}.time, loudnessStructure_TV_Moore{1}.STLlevel)
% subplot(212), plot(loudnessStructure_TV_Moore{1}.time, loudnessStructure_TV_Moore{1}.LTLlevel)
% 
% help Loudness_TimeVaryingSound_Zwicker
% %               - Lx   : loudness level exceeded during x percent of the signal (x is
% %                 the value of the input variable named x_ratio)
% %               - Lt   : loudness level exceeded during t seconds of the signal (t is
% %                 the value of the input variable named t_duration)
% loudnessStructure_TV_Zwicker{1}.Lx
% loudnessStructure_TV_Zwicker{1}.Lt
% help Loudness_TimeVaryingSound_Moore
% %               - STLlevel: short-term loudness level (phon) vs time
% %               - LTLlevel: long-term loudness level (phon) vs time
% %               - STLlevelmax: max of STL level value (phon)
% %               - LTLlevelmax: max of LTL level value (phon)
% loudnessStructure_TV_Moore{1}.STLlevelmax
% loudnessStructure_TV_Moore{1}.LTLlevelmax

% summarising fundamental frequency information
load yinVals.mat
labels=load('avm-fixed.txt')
[x,sr]=wavread('avm.wav');

% isolate a single note
plot(yinVals.f0(labels(1,1)*yinVals.sr/yinVals.hop:labels(1,2)*yinVals.sr/yinVals.hop))
% soundsc(x(labels(1,1)*sr:labels(1,2)*sr),sr)

% calculate the mean of the F0
figure(1)
meanVal=ones(1,3869)*2.^mean(yinVals.f0(labels(1,1)*sr/32:labels(1,2)*sr/32))*440;
plot(2.^yinVals.f0(labels(1,1)*yinVals.sr/yinVals.hop:labels(1,2)*yinVals.sr/yinVals.hop)*440)
hold on
plot(meanVal,'r')
title('Simple mean')
hold off

% calculate the robust mean
sortedVals=2.^sort(yinVals.f0(labels(1,1)*sr/32:labels(1,2)*sr/32))*440;
robustMean=ones(1,3869)*mean(sortedVals(length(sortedVals)*0.05:length(sortedVals)*0.95));

figure(2)
subplot(211)
plot(sort(2.^yinVals.f0(labels(1,1)*sr/32:labels(1,2)*sr/32))*440)
title('Sorted F0s')
subplot(212)
plot(2.^yinVals.f0(labels(1,1)*yinVals.sr/yinVals.hop:labels(1,2)*yinVals.sr/yinVals.hop)*440)
hold on
plot(robustMean,'r')
title('Robust Mean')
hold off

% calculate perceived pitch
% times.ons=labels(:,1)';
% times.offs=labels(:,2)';
% cents=getCentVals(times,yinVals);
% f0s=2.^yinVals.f0(labels(2,1)*sr/32:labels(2,2)*sr/32)*440;
% perceivedPitch(f0s,sr)
for i = 1 : length(labels)
    f0Vals=2.^yinVals.f0(labels(i,1)*yinVals.sr/yinVals.hop:labels(i,2)*yinVals.sr/yinVals.hop)*440;
    cents=yinVals.f0(labels(i,1)*yinVals.sr/yinVals.hop:labels(i,2)*yinVals.sr/yinVals.hop);
    pp(i)=perceivedPitch(f0Vals, 1/yinVals.sr*yinVals.hop, 100000);
    vibrato{i}=fft(cents-mean(cents));
    vibrato{i}(1)=0;
    vibrato{i}(round(end/2):end) = 0;
    [vibratoDepth(i) noteVibratOpos(i)] = max(abs(vibrato{i}));
    vibratoDepth(i)=vibratoDepth(i) * (44100/32) / length(vibrato{i}) * 2;
    vibratoRate(i) = noteVibratOpos(i) * (44100/32) / length(vibrato{i});
    figure(3)
    subplot(2,3,i)
    t=[1:length(f0Vals)]/yinVals.sr*yinVals.hop;
    plot(t,f0Vals)
    title(sprintf('Note %i F0 Trace',i))
    xlabel('Seconds')
    ylabel('Hertz')
    [dctVals{i}, dctApprox{i}]=noteDct(f0Vals,3,1/yinVals.sr*yinVals.hop);
    figure(4)
    subplot(2,3,i)
    plot(dctApprox{i})
    title(sprintf('Note %i DCT Approx',i))
    xlabel('Seconds')
    ylabel('Hertz')    
    sortedVals=sort(f0Vals);
    sprintf('Note %i: The Lx level (Zwicker) is %f and the Lt level (Zwicker) is %f', i, loudnessStructure_TV_Zwicker{i}.Lx,loudnessStructure_TV_Zwicker{i}.Lt)
    sprintf('Note %i: The STL level max (Moore) is %f and the LTL level max (Moore) is %f', i, loudnessStructure_TV_Moore{i}.STLlevelmax,loudnessStructure_TV_Moore{i}.LTLlevelmax)
    sprintf('Note %i: The simple mean is %f, the robust mean is %f, and the perceived pitch calculation is %f', i, mean(f0Vals),mean(sortedVals(length(sortedVals)*0.05:length(sortedVals)*0.95)),pp(i))
    sprintf('Note %i: The vibrato rate is %f and the vibrato depth is %f\n', i, vibratoRate(i), vibratoDepth(i))
    pause
end