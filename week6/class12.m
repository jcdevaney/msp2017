% run the dynamic time warping alignment (DTW) alignment  to get  
% onset and offset estimates for avm.wav, with visualisation
[x,sr]=wavread('avm.wav');
align=runDTWAlignment('avm.wav','avm.mid',1);
align=runDTWAlignment('avm.wav','avmTransposed.mid',1);

% you can either use this slightly flawed estimates or you can use 
% Audacity to fix them, to do so you need to export the estimates
% into a text file with the onsets in the first column and the offsets
% in the second column
% times=[align.on, align.off]
% save('avm.txt','times','-ascii')

% once you have corrected the estimates in Audacity, you can export them
% in the same format and re-import then into MATLAB
labels=load('avm-fixed.txt')

% play each note
% for i = 1 : size(labels,1)
%     soundsc(x(labels(i,1)*sr:labels(i,2)*sr),sr)
%     pause
% end

% you can use the same loop to run YIN and plot the results
for i = 1 : size(labels,1)
    yinVals{i}=yin(x(round(labels(i,1)*sr):round(labels(i,2)*sr)),sr);
    % note the large number of parentheses here to enforce teh desired 
    % order of operations, this could also be written as
    % t = 1:length(yinVals.f0);
    % t = t/sr*32;
    % t = t + labels(i,1);    
    t=(((1:length(yinVals{i}.f0))/sr*32))+labels(i,1);
    subplot(311)
    plot(yinVals{i}.f0)
    subplot(312)
    plot(yinVals{i}.ap)
    subplot(313)
    plot(yinVals{i}.pwr)
    pause
end

% alternatively run YIN on the entire waveform and then index into the 
% results using the labels, this has the advantage of not minimizing
% the amount of zero padding and thus the number of NaN YIN generates
yinVals2=yin(x,sr);
for i = 1 : size(labels,1)
    idx=round(labels(i,1)*yinVals2.sr/yinVals2.hop):round(labels(i,2)*yinVals2.sr/yinVals2.hop);
    t=(((1:length(yinVals2.f0(idx)))/yinVals2.sr/yinVals2.hop))+labels(i,1);
    subplot(311)
    plot(t,yinVals2.f0(idx))
    subplot(312)
    plot(t,yinVals2.ap(idx))
    subplot(313)
    plot(t,yinVals2.pwr(idx))
   pause
end

% plot YIN f0, ap, and pwr in a manner similar to the ouptu of YIN
% when no output is saved - main difference is f0 is plotted in Hz
plotYinVals(yinVals2)
