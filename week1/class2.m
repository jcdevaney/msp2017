%% Wav file basics

% File to load
% file = './r0s.wav';
file = 'r0.wav';

% Load the audio files
[x fs] = wavread(file);

% Size of variables
size(x)
fs

% Compute length of file in seconds
length_s = size(x,1) / fs

% Convert stereo to mono
x = mean(x, 2);
size(x)


%% Basics

% Ranges
a = 1:4
b = 5:2:11
c = 11:-2:5

% Basic mathematical operations
a + b
a - b
a .* b
a ./ b

% Index into vector
x(1)
x(1:5)
x(5:10)

% Transpose
x(5:10)'


%% Plotting

% Plot time-domain signal
plot(x)

% Plot time-domain signal with correct x-axis
t = (1:size(x,1)) / fs;
plot(t, x)

% Normalize signal to have maximum excursion of 1
excursion = max(abs(x))
x = x / excursion;
max(abs(x))
plot(t, x)

% Label axes
xlabel('Time (s)')
ylabel('Amplitude')

% Title
title('R0 Wavform')

% Zoom with tool
disp('Zoom with tool')

% Zoom in with xlim
origXl = xlim();
xlim([0 1])

% Zoom back out
xlim(origXl)

% Zoom in with ylim
origYl = ylim();
ylim([-0.1 0.1])

% Zoom back out
ylim(origYl)

% Zoom in with axis
origAxis = axis();
axis([0 1 -.1 .1])

% Zoom back out
axis(origAxis)
