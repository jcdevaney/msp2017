% function [y, taxis, faxis] = mySpecgram(sig, fs, N, win, hop)
% 
% Calculates the spectrogram of sig with the values
%  fs - sampling frequency
%  N - frequency n-points
%  win - window size
%  hop - hop size
% if specified, else the defaults defined below are used
%
% Created by: Johanna Devaney

function [y, taxis, faxis] = mySpecgram(sig, fs, N, win, hop)

if nargin < 2
  % set the sampling rate to 44100
  fs = 44100;
end
if nargin < 3
  % set default n-points to 1024
  N = 1024;
end
if nargin < 4
  % set window size equal to n-points
  win = N;
end
if nargin < 5
  % set hop size equal to one quarter of the window size
  hop = floor(win/4);
end

% check the orientation of the inputted signal, to make sure it is wider than it is high
if (size(sig,1) < size(sig,2))
  sig = sig';
end

ind = 1;
siglen = length(sig);
winfr = zeros(N, length(0:hop:(siglen-N)));

% vector from window function
winVec = hann(win);

for i = 0 : hop : (siglen-N)
  % multiply each by frame by window and place the result side by side 
  % in a matrix, column by columm
  winfr(:,ind) = winVec.*sig((i+1):(i+N));
  ind = ind + 1;
end;

clear sig

% take the fft of the matrix of windows
y = fft(winfr);
y = y(1:(1+N/2),:);

% set x and y axes
taxis = [0:hop:(siglen-N)]/fs;
faxis = [0:(N/2 + 1)]*fs/N;