function plotSpecgram(sig,fs,win_samp,hop_samp,titleString,filename,freqzoom,timezoom)
% Make and plot the spectrogram

[S F T P] = spectrogram(sig, win_samp, win_samp - hop_samp, win_samp, fs);
imagesc(T, F, 10*log10(P))
colorbar

% Alternative plotting
% spectrogram(sig, win_samp, win_samp - hop_samp, win_samp, fs);
% colorbar
% view(-90, 90)
% axis ij

if nargin > 4
    title(titleString)
end

if nargin > 6
    ylim(freqzoom)
end

if nargin > 7
    xlim(timezoom)
end

axis xy

if nargin > 5
	print('-dpng', filename)
end