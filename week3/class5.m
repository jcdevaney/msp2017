
%% Spectrograms of different files

violinFile = 'h.wav';
voiceFile = 'mc.wav';

% Load violin
[x3 fs] = wavread(violinFile);

% Plot time-domain signal before resampling
t3 = (1:size(x3,1)) / fs;
plot(t3, x3);

% Resample
x3 = resample(x3, fsn, fs);

% Plot time domain signal after resampling
t3 = (1:size(x3,1)) / fsn;
plot(t3, x3)

% Reset parameters again
win_s = 0.032;
hop_s = 0.008;
win_samp = round(fs * win_s);
hop_samp = round(fs * hop_s);

% Spectrogram of violin
spectrogram(x3, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij

% Save a plot
print('-dpng', 'spectrogramViolin')


% Load voice file
[x4 fs] = wavread(voiceFile);
x4 = resample(x4, fsn, fs);

% Plot in time-domain
t4 = (1:size(x4,1))/fsn;
plot(t4, x4);

% Spectrogram of voice
spectrogram(x4, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij

% Save plot
print('-dpng', 'spectrogramVoice')
