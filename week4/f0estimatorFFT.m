function f0 = f0estimatorFFT(fftFrame,frequencies,algo)

% take the largest peak
if algo == 1
    [maxVals,maxLoc]=max(fftFrame);
    f0 = frequencies(maxLoc);
end

% take the largest peak at the lowest frequency
% this is done by finding  all the peaks that a > 1/8th of the maximum amplitude in the
% current frame and then selecting the the peak lowest peak as the F0
if algo == 2
    [peakVals,peakLoc]=findpeaks(fftFrame,'minpeakheight',max(fftFrame)/8);
    f0 = frequencies(min(peakLoc));
end