function assign4(filename)

% This function takes a file name and reads the corresponding wave file,
% onset detection function file, and onset estimates file. It then 
% plots the time domain and spectrum of the wave file and the onset
% detection function and onset estimates
% use with filenames: 'kingsLoop' and 'mozartSeg'
%               - the corresponding files are in the datafiles directory
% Created by: Johanna Devaney

% read wav file corresponding to inputted file name and make it mono if 
% need be
[audio,sr]=wavread([filename '.wav']);
if size(audio,2) > size(audio,1)
    audio=audio';
end
if size(audio,2) > 1
    audio=mean(audio,2);
end

% run a STFT anlysis of the waveform
[spec, spectaxis, specfaxis] = mySpecgram(audio, sr, 1024, 1024, 256);

% load the onset and onset detection data exported from Sonic Visualiser
onsets=load([filename '-onsets.txt']);
onsetFunction=load([filename '-onsetsFunction.txt']);

% plot the data
figure(1)
% first, the waveform
subplot(411)
t=[1:length(audio)]/sr;
plot(t,audio)
axis tight
ylabel('Amplitude')
title('Time Domain Representation')

% then the spectrum
subplot(412)
imagesc(spectaxis,specfaxis/1000,10*log(abs(spec)))
axis xy
ylabel('Frequency (kHz)')
title('Frequency Domain Representation')

% followed by the onset detection function
subplot(413)
plot(onsetFunction(:,1),onsetFunction(:,2))
axis tight
title('Onset Detection Function')

% and finally the onset estimates
subplot(414)
clicks = zeros(size(audio));
onsets_samp = round(onsets * sr);
clicks(onsets_samp) = 1;
plot(t,clicks)
axis tight
xlabel('Time (sec)')
title('Onset Estimates')