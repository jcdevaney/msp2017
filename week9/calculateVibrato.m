function [vibratoDepth, vibratoRate]=calculateVibrato(noteVals,sr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [vibratoDepth, vibratoRate]=calculateVibrato(noteVals,sr)
%
% Description: Calculate vibrato rate and depth with FFT
%
% (c) copyright 2015, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L = length(noteVals); % Length of signal
Y = fft(noteVals)/L;  % Run FFT on normalized note vals
w = [0:L-1]*sr/L;     % Set FFT frequency grid

[vibratoDepthTmp, noteVibratOpos] = max(abs(Y));    % Find the max value and its position
vibratoDepth =vibratoDepthTmp*2; % Multiply the max by 2 to find depth (above and below zero)
vibratoRate = w(noteVibratOpos); % Index into FFT frequency grid to find position in Hz