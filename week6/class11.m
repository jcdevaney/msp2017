% onset detection
[x3,sr]=wavread('kingsLoop.wav');
% make the file mono
x3=x3(:,1);
% calculate a spectrogram with a 20ms window-size and a 10ms hop-size
figure(1)
[onspecval, onspectime, onspecfreq]  = mySpecgram(x3, sr, round(sr*0.02));
% input the spectrogram into the onset detection function
onval = myOnsetDetector(onspecval, sr, 0);
% plot 
figure(2)
subplot(211)
t=((1:length(x3))/sr);
plot(t,x3)
subplot(212)
plot(onspectime(1:end-1),onval)
% peakpick the onsets
[peakLoc,peakVal]=findpeaks(onval,'MinPeakHeight',1000,'MinPeakDistance', 25);
% play the audio and esitmated onsets together
clicks=zeros(size(x3));
clicks(round(onspectime(peakVal)*sr))=1;
soundsc((x3*0.25)+clicks,sr)

pause

[x3,sr]=wavread('avm.wav');
% make the file mono
x3=x3(:,1);
% calculate a spectrogram with a 20ms window-size and a 10ms hop-size
figure(3)
[onspecval, onspectime, onspecfreq]  = mySpecgram(x3, sr, round(sr*0.02));
% input the spectrogram into the onset detection function
onval = myOnsetDetector(onspecval, sr, 0);
% plot 
figure(4)
subplot(211)
t=((1:length(x3))/sr);
plot(t,x3)
subplot(212)
plot(onspectime(1:end-1),onval)
% peakpick the onsets
[peakLoc,peakVal]=findpeaks(onval,'MinPeakHeight',1000,'MinPeakDistance', 25);
% play the audio and esitmated onsets together
clicks=zeros(size(x3));
clicks(round(onspectime(peakVal)*sr))=1;
soundsc((x3*0.25)+clicks,sr)