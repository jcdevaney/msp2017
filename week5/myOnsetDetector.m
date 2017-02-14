% function onsets = myOnsetDetector(spec, sr)
% 
% This function 
%	computes spectrogram such that you know how much time has passed 
%   for each column (in this case 10ms, 100Hz) takes difference along each row of the magnitude and then sum the log of the differences
%	takes the gradients the magnitude of the spectrogram row by row and then sum them log scale first
%	recalculate sampling rate

%
% Created by: Johanna Devaney


function onsets = myOnsetDetector(spec, sr, melfreqFlag)

if melfreqFlag
    % calculate a mel frequency matrix for the inputted spectrogram
    [wts,binfrqs] = fft2melmx(size(spec,1), sr);

    % mutliply the inputted spectrogram by melfrequency matrix (y)
    melfreq = wts * spec;

    % take the log of the magnitiude of the mel frequency spectrogram
    mflog = 20*log10(abs(melfreq));
else
    mflog = 20*log10(abs(spec));
end

% for each band/row (i) look at difference between j in row i and j+1 in row i 
mfdiff = diff(mflog,1,2);
mfdiff = abs(mfdiff);

% take the sum of the matrix
mdiff = sum(mfdiff,1);	

% take the max of the sum of difference calculations on the (mel frequency) spectrogram and zero
onsets = max(mdiff, 0);

subplot(411)
imagesc(mflog)
subplot(412)
plot(mfdiff)
subplot(413)
plot(mdiff)
subplot(414)
plot(onsets)
