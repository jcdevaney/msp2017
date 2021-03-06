close all

% % summarising fundamental frequency information
load yinVals.mat
labels=load('avm-fixed.txt');
[x,sr]=audioread('avm.wav');

% isolate a single note
figure(1)
f0Vals=2.^yinVals.f0(ceil(labels(1,1)*sr/yinVals.hop):floor(labels(1,2)*sr/yinVals.hop))*440;
timeVec=(1:length(f0Vals))/yinVals.sr*yinVals.hop;
plot(timeVec,f0Vals)
% soundsc(x(labels(1,1)*sr:labels(1,2)*sr),sr)

pause

% calculate the mean of the F0
figure(2)
subplot(311)
meanVal=mean(f0Vals);
meanValPlot=ones(1,size(f0Vals,2))*meanVal;
plot(timeVec,f0Vals)
hold on
plot(timeVec,meanValPlot,'r')
title('Simple mean')
hold off

% calculate the robust mean
subplot(312)
sortedVals=sort(f0Vals);
robustMean=mean(sortedVals(ceil(length(sortedVals)*0.05):floor(length(sortedVals)*0.95)));
robustMeanPlot=ones(1,size(f0Vals,2))*robustMean;
plot(timeVec,f0Vals)
hold on
plot(timeVec,robustMeanPlot,'r')
title('Robust mean')
hold off

% calculate the perceived pith
subplot(313)
ppitch=perceivedPitch(f0Vals, 1/yinVals.sr*yinVals.hop, 100000);
ppitchPlot=ones(1,size(f0Vals,2))*ppitch;
plot(timeVec,f0Vals)
hold on
plot(timeVec,ppitchPlot,'r')
title('Perceived Pitch')
hold off

sprintf('Note %i: The simple mean is %0.2f, the robust mean is %0.2f, and the perceived pitch calculation is %0.2f', 1, meanVal,robustMean,ppitch)

pause

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

% calculate perceived pitch
% times.ons=labels(:,1)';
% times.offs=labels(:,2)';
% cents=getCentVals(times,yinVals);
% f0s=2.^yinVals.f0(labels(2,1)*sr/32:labels(2,2)*sr/32)*440;
% perceivedPitch(f0s,sr)
for i = 1 : length(labels)
    perceived pitch
    f0Vals=2.^yinVals.f0(ceil(labels(i,1)*yinVals.sr/yinVals.hop):floor(labels(i,2)*yinVals.sr/yinVals.hop))*440;
    cents=yinVals.f0(ceil(labels(i,1)*yinVals.sr/yinVals.hop):floor(labels(i,2)*yinVals.sr/yinVals.hop));
    pp(i)=perceivedPitch(f0Vals, 1/yinVals.sr*yinVals.hop, 100000);
    % vibrato
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
    sprintf('Note %i: The simple mean is %0.2f, the robust mean is %0.2f, and the perceived pitch calculation is %0.2f', i, mean(f0Vals),mean(sortedVals(ceil(length(sortedVals)*0.05):floor(length(sortedVals)*0.95))),pp(i))
    sprintf('Note %i: The vibrato rate is %0.2f and the vibrato depth is %0.2f\n', i, vibratoRate(i), vibratoDepth(i))
    
    % summarizing power data using root mean square    
    pwrVals=yinVals.pwr(ceil(labels(i,1)*yinVals.sr/yinVals.hop):floor(labels(i,2)*yinVals.sr/yinVals.hop));
    rmsCalc=rms(pwrVals(~isnan(pwrVals)));
    figure(5)
    subplot(2,3,i)
    plot(pwrVals)
    title(sprintf('Note %i PwrVals',i))
    xlabel('Seconds')
    ylabel('Sqrt(Pwr)')     
    hold on
    plot(ones(1,length(pwrVals))*rmsCalc,'r')
    hold off
    
    sprintf('Note %i: The RMS value is %f', i, rmsCalc)
    
    figure(6)
    subplot(2,3,i)
    plot(loudnessStructure_TV_Zwicker{i}.time, loudnessStructure_TV_Zwicker{i}.InstantaneousLoudnessLevel)
    title(sprintf('Note %i Zwicker',i))
    xlabel('Seconds')
    ylabel('Instantaneous Loudness Lvl')     
    
    sprintf('Note %i: The Lx level (Zwicker) is %0.2f and the Lt level (Zwicker) is %0.2f', i, loudnessStructure_TV_Zwicker{i}.Lx,loudnessStructure_TV_Zwicker{i}.Lt)

    figure(7)
    subplot(2,3,i)
    plot(loudnessStructure_TV_Moore{i}.time, loudnessStructure_TV_Moore{i}.LTLlevel)
    title(sprintf('Note %i Moore',i))
    xlabel('Seconds')
    ylabel('Long-term loudness')  
    
    sprintf('Note %i: The STL level max (Moore) is %0.2f and the LTL level max (Moore) is %0.2f', i, loudnessStructure_TV_Moore{i}.STLlevelmax,loudnessStructure_TV_Moore{i}.LTLlevelmax)

    pause
end

