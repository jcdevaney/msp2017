% autocorrelation
x=-pi:0.01:pi;
[autoCorr1, autoCorr2, autoCorr3]=myAutocorr(sin(x*30),60);

% YIN 
[x2,sr]=wavread('avmA.wav');

% running YIN without saving the output will plot the F0 estimate,
% aperiodicity, and power estimates
yin(x2,sr)

% other you can save the output into a structure
R=yin(x2,sr)

% in addition to sampling rate, you can pass additional parameters 
% to yin as a structure
P.sr=44100;
P.minf0 = 220;
P.maxf0 = 880;
P.thresh = 0.01;
yin(x2,P)