
% load files
[a1,fs1]=wavread('r1.wav');
[a2,fs2]=wavread('r2.wav');

% plot and save waveforms
plotWaveform(a1,fs1,'R1 Waveform','r1waveform');
plotWaveform(a1,fs1,'R1 Waveform (Zoom)','r1waveform-zoom',[15 25],[-0.5 0.5]);
plotWaveform(a2,fs2,'R2 Waveform','r2waveform');
plotWaveform(a2,fs2,'R2 Waveform (Zoom)','r2waveform-zoom',[0 10],[-0.8 0.8]);

% plot and save specograms
% window size
win_s = 0.064;
win_samp = round(fs * win_s);
% hop size
hop_s = 0.016;
hop_samp = round(fs * hop_s);

plotSpecgram(a1,fs1,win_samp,hop_samp,'R1 Spectrogram','r1specgram')
plotSpecgram(a1,fs1,win_samp,hop_samp,'R1 Spectrogram (Zoom)','r1specgram-zoom',[0 5000])
plotSpecgram(a2,fs2,win_samp,hop_samp,'R2 Spectrogram','r2specgram')
plotSpecgram(a2,fs2,win_samp,hop_samp,'R2 Spectrogram (Zoom)','r2specgram-zoom',[0 5000])

% Use shorter window with corresponding shorter hop
win_s = 0.016;
win_samp = round(fs * win_s);
hop_s = win_s / 4;
hop_samp = round(fs * hop_s);

plotSpecgram(a1,fs1,win_samp,hop_samp,'R1 Spectrogram - Shorter Window (Zoom)','r1specgramShorter-zoom',[0 5000])
plotSpecgram(a2,fs2,win_samp,hop_samp,'R2 Spectrogram - Shorter Window (Zoom)','r2specgramShorter-zoom',[0 5000])