function plotYinVals(yinVals)
% Plot YIN vals in a manner similar to the plot produced by YIN 
% when not output is saved
% Written by: Johanna Devaney

% Input is the output structure from YIN, a time vector to 
subplot(311)
% this code is taken from YIN to make yellow plots for 
% estimates that have a high periodicity (> 0.4)
highPeridocity = yinVals.f0;
highPeridocity(find(yinVals.ap0>0.4)) = nan;
t=(((1:length(yinVals.f0))/yinVals.sr*yinVals.hop));
plot(t,2.^yinVals.f0*440,'y',t,2.^highPeridocity*440,'b')
ylabel('Frequency(Hz)')

% plot aperiodicty
subplot(312)
plot(t,sqrt(yinVals.ap0),'b')
ylabel('Squareroot Aperiodicity')

% plot power
subplot(313)
plot(t,sqrt(yinVals.pwr),'b')
ylabel('Squareroot Power')
xlabel('Time (Seconds)')