
%% Spectrograms of different files

violinFile = 'h.wav';
voiceFile = 'mc.wav';

% Load violin
[x3 fs3] = wavread(violinFile);

% Plot time-domain signal before resampling
t3 = (1:size(x3,1)) / fs3;
plot(t3, x3);

% Set parameters
win_s = 0.032;
hop_s = 0.008;
win_samp = round(fs3 * win_s);
hop_samp = round(fs3 * hop_s);

% Spectrogram of violin
spectrogram(x3rs, win_samp, win_samp - hop_samp, win_samp, fs3); colorbar; view(-90, 90); axis ij

% Save a plot
print('-dpng', 'spectrogramViolin')


% Resample
fsn = 8000;
x3rs = resample(x3, fsn, fs3);

% Plot time domain signal after resampling
t3rs = (1:size(x3rs,1)) / fsn;
plot(t3rs, x3rs)

% Reset parameters
win_s = 0.032;
hop_s = 0.008;
win_samp = round(fsn * win_s);
hop_samp = round(fsn * hop_s);

% Spectrogram of violin
spectrogram(x3rs, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij

% Save a plot
print('-dpng', 'spectrogramViolin-resample')


% Load voice file
[x4 fs4] = wavread(voiceFile);


% Plot in time-domain
t4 = (1:size(x4,1))/fs4;
plot(t4, x4);

% Spectrogram of voice
spectrogram(x4, win_samp, win_samp - hop_samp, win_samp, fs4); colorbar; view(-90, 90); axis ij

% Save plot
print('-dpng', 'spectrogramVoice')


% Reset parameters again
win_s = 0.032;
hop_s = 0.008;
win_samp = round(fs3 * win_s);
hop_samp = round(fs3 * hop_s);


% resample
x4 = resample(x4, fsn, fs4);

% Reset parameters again
win_s = 0.032;
hop_s = 0.008;
win_samp = round(fsn * win_s);
hop_samp = round(fsn * hop_s);

% Plot in time-domain
t4 = (1:size(x4,1))/fsn;
plot(t4, x4);

% Spectrogram of voice
spectrogram(x4, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij

% Save plot
print('-dpng', 'spectrogramVoice-resample')


%%%%%%%%%%%%%%%%%


% Sinusoid wave
%   sinusoid
%   (omega) – frequency
%   (phi) – phase
%   t – time
%   x - signal

% sine
%   plot a sine wave in MATLAB
x = -pi:0.01:pi;
plot(x,sin(x))

% Cosine wav
%   plot a cosine wave in MATLAB
x = -pi:0.01:pi;
plot(x,cos(x))

% Discrete Fourier Transform (DFT)
%   dftN – number of samples
%   n – current sample
%   x – input signal
%   X – spectrum of x
%   k – current frequency
%   i – imaginary component

% Fast Fourier Transform (FFT)
%   See the MATLAB's FFT documentation for an example.

% Inverse Fast Fourier Transform (IFFT)
%   - re-construct signal from FFT
%   - see MATLAB's IFFT documentation

% Spectrogram
%   Window types - rectangular, triangular, hanning, blackman
%               - simple spectrogram function to view the spectrogram, enter the command: imagesc(taxis, faxis, db(y))

% The figure below shows a spectrogram of avm.wav (the opening phrase of Schubert's Ave Maria)
% stft
% The spectrogram function returns a Short-Time Fourier Transform (STFT) of the signal, a windowed application of the DFT to the signal.