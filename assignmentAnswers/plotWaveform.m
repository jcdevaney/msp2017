function plotWaveform(sig,fs,titleString,filename,xzoom,yzoom)
   
% Plot time-domain signal with correct x-axis
t = (1:size(sig,1)) / fs;

% Normalize signal to have maximum excursion of 1
excursion = max(abs(sig));
sig = sig / excursion;
plot(t, sig)

% Label axes
xlabel('Time (s)')
ylabel('Amplitude')

if nargin > 2
    title(titleString)
end

if nargin > 4
    xlim(xzoom);
end

if nargin > 5
    ylim(yzoom)
end

if nargin > 3
    print('-dpng', filename)
end