function res=movingavg(sig, winsize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% res=movingavg(sig, winsize)
%
% Description: Calculate a moving average with the inputted window size
%
% (c) copyright 2010, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sig=sig(~isnan(sig));

winsize=round(winsize);

%res = filter(1/winsize, [1 -1+1/winsize], sig, mean(sig(1:winsize)));

tmp = filter(ones(winsize,1)/winsize,1,sig);
res = [ones(1,floor(winsize/2))*NaN tmp(winsize:end) ones(1,floor((winsize-1)/2))*NaN];