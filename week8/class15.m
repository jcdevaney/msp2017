% MIDI toolbox
% examples from manual

% for the folk song example file
laksin=midi2nmat('laksin.mid');

%visualise the notes and dynamics
figure(1)
pianoroll(laksin,'name','sec','vel');
figure(2)
pianoroll(laksin,'num','beat','vel');
 
% for the Bach prelude example file
prelude = readmidi('wtcii01a.mid');

% visualize the notes and dynamics
figure(3)
pianoroll(prelude,'name','sec','vel');
figure(4)
pianoroll(prelude,'num','beat','vel');

pause
close all

% histograms
% plot the distribution of pitches in the folk song
figure(1)
plotdist(ivdist1(laksin))

pause
close all

% autocorrelation
% use autocorrelation to calculate the degree of self-similarity in the
% signal, e.g., where musical material returns
figure(1)
plotmelcontour(laksin,0.5,'abs','b','ac');

% use of autocorelation to estimate meter
figure(2)
onsetacorr(laksin,4,'fig');
meter(laksin)
