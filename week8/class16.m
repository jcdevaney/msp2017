% script of commands from MIR Toolbox Primer

% check that mirtoolbox is installed
ver mirtoolbox

% listen to an audio file
mirplay('ragtime')

% read an audio file
miraudio('ragtime')
% store the output of miraudio
a=miraudio('ragtime');
% display the output
mirstat(a)
% store the output to a structure and plot it
structVals=mirstat(a)
figure(2)
subplot(211)
plot(structVals.Mean)
% versus the output of the built in audioread function
[x,sr]=audioread('ragtime.wav');
subplot(212)
plot(mean(x,2))


% extract a section of an audio file
miraudio('ragtime','Extract',0,1)
miraudio('ragtime','Extract',0,0.5)

% look for the optional commands for miraudio
help miraudio
% split into two separate channels
miraudio('ragtime','Extract',0,0.5,'Mono',0)

% calculate root mean square of signal
mirrms('ragtime')
mirrms('ragtime','frame')

% calculate fft
mirspectrum('ragtime')
% calculate stft
mirspectrum('ragtime','Frame')
% view options for mirspectrum
help mirspectrum
% calculate up to a set frequency
mirspectrum('ragtime','Frame','Max', 3000)
% collapse spectrum into a single octave with specified window and hop
mirspectrum('ragtime','Frame',1,0.1,'Max', 3000,'Collapsed')
% calculate using mel spectrum
mirspectrum('ragtime','Frame',1,0.1,'Mel')

% script of commands from MIR Toolbox Primer

% recap on getting the data from mirtoolbox
% calculate chromagram
c = mirchromagram('ragtime', 'Frame')
% save values
vals=mirgetdata(c);
figure(2)
imagesc(vals)
axis xy
% view statistics
structures=mirstat(c)

% mfccs
c = mirmfcc('ragtime', 'Frame')

% spectral flux
s = mirspectrum('ragtime', 'Frame')
f=mirflux(s)
mirplayer(f)

% brightness
a = mirbrightness('ragtime', 'Frame')
mirbrightness(a, 'Frame')
% change the path to this directory as needed
cd ~/Dropbox/matlab/MIRtoolbox1.4.1/MIRToolboxDemos/train_set
b = mirbrightness('Folder')
mirplay('Folder', 'Increasing', b)

% spectral centroid
c = mircentroid('ragtime', 'Frame')
mirplayer(c)
d = mircentroid('Folder')
mirplay('Folder', 'Increasing', d)

% sensory dissonance
r = mirroughness('ragtime')
mirplayer(r)
r2 = mirroughness('Folder')
m = mirmean(r2)
mirplay('Folder', 'Increasing', m)

% save data to file
mirexport('myresults.txt', c, r)