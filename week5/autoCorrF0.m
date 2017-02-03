function period=autoCorrF0(x,plotFlag)

autocorrVec=xcorr(x);
if plotFlag
    plot(autocorrVec)
end
[peakVal, peakLoc]=findpeaks(autocorrVec);
[maxVal,maxLoc]=max(peakVal);

period=maxLoc;