function plotxcorr(x)

subplot(211)
plot(x)
subplot(212)
plot(xcorr(x,'coeff'))