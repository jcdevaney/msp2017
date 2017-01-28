% function [melcoeff, xaxis, yaxis] = myMFCC(x, sr, y, N, win, hop)
% 
% This function uses fft2melmx by Daniel Ellis
%   available at: http://www.mathworks.com/matlabcentral/fileexchange/28472-time-frequency-automatic-gain-control--agc-/content/tf_agc/fft2melmx.m
%
% Calculates the MFCCs of x. If y is specified that is used as the spectogram
% for the signal, otherwise it is calculated from x with the following values
%  N - n-points
%  win - window size
%  hop - hop size
% if specified, else the defaults defined below are used
%
% After running this funciton you will likely want to limit the coefficients to 2:13
% and normalize the coefficients with the following code
%  melcoeff = melcoeff(2:13,:);
%  melcoeffnorm = (melcoeff - repmat(mean(melcoeff,2), 1, size(melcoeff,2))) ./ repmat(std(melcoeff,[],2), 1, size(melcoeff,2));
% Created by: Johanna Devaney

function [melcoeff, xaxis, yaxis] = myMFCC(x, sr, y, N, win, hop)

if nargin < 2
  sr = 44100;
end

% map the log amplitudes of the spectrum obtained above onto the mel scale, using triangular overlapping windows.
if nargin < 3
    % Calculate stft
	y = abs(mySpecgram(x)).^2; 
else
	% Take the square of the magnitude of the spectrogram
    y = abs(y).^2;
end

if nargin < 4
  % Set N-points
  N = round(sr * 0.1);
end

if nargin < 5
  % Set window size
  win = N;
end

if nargin < 6
  % Set hop size
  hop = win/2;
end

siglen = length(x);
nfft = size(y,1);


% wts is a matrix where columns are the mel frequencies and the rows are the linear frequencies
[wts,binfrqs] = fft2melmx(nfft, sr);

% convert the spectrogram to the mel frequency scale
melfreq = wts * y;

% take the Discrete Cosine Transform of the list of mel log-amplitudes
melcoeff = dct(log(melfreq));

% set x and y axes
xaxis = [0:hop:size(x,1)]/sr;
yaxis = 1:30;