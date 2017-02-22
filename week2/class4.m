% File to load
% file = './r0s.wav';
file = 'r0.wav';

% Load the audio files
[x fs] = wavread(file);
t = (1:size(x,1)) / fs;


%% Using data from r0.csv

% File containing comma-separated values to load
csvFile = 'r0.csv';

% Load data into a matrix
csv = load(csvFile);

% Plot vertical lines for the beats
beatPos_s = csv(:,1);
beatTop = ones(size(beatPos_s));
plot(t, x, [beatPos_s beatPos_s]', [-beatTop beatTop]', 'r')

% Make clicks at beat times
clicks = zeros(size(x));
beatPos_samp = round(beatPos_s * fs);
clicks(beatPos_samp) = 1;
plot(t, x, t, clicks);

% Play itme
%soundsc(x + clicks, fs);

% Write clicks to wav file
wavwrite(x + clicks, fs, 'r0WithClicks.wav')

% Use noise bursts instead of clicks
bursts = zeros(size(x));
burstLen_s = 0.002;
burstLen_samp = round(burstLen_s * fs);
for i = 1:length(beatPos_samp)
    bursts(beatPos_samp(i) + (0:burstLen_samp-1)) = rand(burstLen_samp,1) - 0.5;
end
plot(t, x, t, bursts)

% Play it
%sound(x + bursts, fs)

% Write bursts to wav file
wavwrite(x + bursts, fs, 'r0WithBursts.wav')


% Plot dynamics curve with beats
dynamics = csv(:,3);
plot(t, x, t, clicks, beatPos_s, dynamics / 100, '.-')


%% Advanced plotting

% Show documentation for plot() function
%doc plot

% Make sinusoid
t2 = linspace(0, 2*pi, 101);
x2 = sin(t2 * 5);

% Basic plot
plot(t2, x2)

% Change plot style
plot(t2, x2, '.')
plot(t2, x2, '.-')
plot(t2, x2, '-.')
plot(t2, x2, 'x-')
plot(t2, x2, 'x-r')

% Plot two lines at the same time
plot(t2, x2, t2, -x2)

% Same, but using hold
plot(t2, x2)
hold on
plot(t2, -x2, 'g')
hold off


%% Spectrograms

% Documentation of the "spectrogram" function
%doc spectrogram

% Compute spectrogram parameters
win_s = 0.064;
hop_s = 0.016;
win_samp = round(fs * win_s);
hop_samp = round(fs * hop_s);

% Make and plot the spectrogram
spectrogram(x, win_samp, win_samp - hop_samp, win_samp, fs);
colorbar
view(-90, 90)

% Plot the spectrogram yourself
[S F T P] = spectrogram(x, win_samp, win_samp - hop_samp, win_samp, fs);
imagesc(T, F, 10*log10(P))
axis xy
colorbar

% Downsample to new fs
fsn = 8000;
xn = resample(x, fsn, fs);

% Compute spectrogram parameters
win_samp = round(fsn * win_s);
hop_samp = round(fsn * hop_s);

% Plot spectrogram
spectrogram(xn, win_samp, win_samp - hop_samp, win_samp, fsn);
colorbar
view(-90, 90)
axis ij

% Use shorter window
win_s = 0.016;
hop_s = 0.016;
win_samp = round(fsn * win_s);
hop_samp = round(fsn * hop_s);
spectrogram(xn, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij

% Use longer window
win_s = 0.256;
hop_s = 0.016;
win_samp = round(fsn * win_s);
hop_samp = round(fsn * hop_s);
spectrogram(xn, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij

% Use shorter window with corresponding shorter hop
win_s = 0.016;
hop_s = win_s / 4;
win_samp = round(fsn * win_s);
hop_samp = round(fsn * hop_s);
spectrogram(xn, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij

% Use longer window with corresponding longer hop
win_s = 0.256;
hop_s = win_s / 4;
win_samp = round(fsn * win_s);
hop_samp = round(fsn * hop_s);
spectrogram(xn, win_samp, win_samp - hop_samp, win_samp, fsn); colorbar; view(-90, 90); axis ij
