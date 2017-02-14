% autocorrelation
x=-pi:0.01:pi;
autoval=myAutocorr(sin(x*30));

subplot(211)
plot(sin(x*30))
subplot(212)
plot(autoval)

[val,loc]=max(autocorr(2:end,1));
F0estimate = loc + 1

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


[x2,sr]=wavread('avmA.wav');
yin(x2,sr)
yinVals=ans;
yinVals
figure(2)
subplot(211)
plot(yinVals.f0)
xaxis
axis
format short g
axis
axis([0 4000 -0.5 0.6])
subplot(413)
plot(sqrt(yinVals.ap))
axis
axis([0 4000 0 1])
plot(sqrt(yinVals.ap0))
axis([0 4000 0 1])
subplot(414)
plot(sqrt(yinVals.pwr))
subplot(211)
xlabel('Oct. re: 440 Hz')
ylabel('Oct. re: 440 Hz')
subplot(413)
ylabel('sqrt(apty)')
subplot(414)
ylabel('sqrt(pwr)')