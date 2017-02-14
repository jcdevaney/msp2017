% function assign2(filename)
%
%  Plots the log spectrogram, MFCCs, Cochleagram, and Chromagram 
%  of the inputting audio file
%
% Created by: Johanna Devaney
function assign2(filename)

if nargin < 1
  error('Need to specify a filename');
end

[x,sr]=wavread(filename);
% format short g

%calculate a spectrogram
[specval, spectime, specfreq]  = mySpecgram(x, sr, round(sr*0.1));
% plot the spectrogram
specfreq=specfreq/1000;
makeSubplot(221, spectime,specfreq,10*log10(abs(specval)), 'Log Amplitude Spectrogram','Sectrogram frames (sec)','Linear Freq (kHz)');

% cochleagram using Lyon's Passive Ear model (Auditory Toolbox)
cochval=LyonPassiveEar(x,sr,100);
[filters, cochfreq] = DesignLyonFilters(sr,8,8/32);
% cochfreq=fliplr(cochfreq);
cochfreq=cochfreq/1000;
% plot the cochleagram
cochtime=[1:size(cochval,1)]/10;
makeSubplot(222, cochtime, cochfreq, cochval, 'Cochleagram','Cochleagram frames (sec)','Log Freq (kHz)');

%calculate MFCCs and limit them to coefficients between 2 and 13
[mfccval, mfcctime, mfccfreq] = myMFCC(x, sr, specval);
mfccval = mfccval(2:13,:);
mfccvalnorm = (mfccval - repmat(mean(mfccval,2), 1, size(mfccval,2))) ./ repmat(std(mfccval,[],2), 1, size(mfccval,2));
% plot the mfccs
makeSubplot(223, mfcctime, mfccfreq(2:13), 10*log10(abs(mfccvalnorm)), 'MFCCs','MFCC frames (sec)','MFCC coeff (scaled)');

%calculate chroma using the Chroma Toolbox 
[f_audio,sideinfo] = wav_to_audio('', '', filename);
shiftFB = estimateTuning(f_audio);
paramPitch.winLenSTMSP = 4410;
paramPitch.shiftFB = shiftFB;
[f_pitch,sideinfo] = audio_to_pitch_via_FB(f_audio,paramPitch,sideinfo);
paramCP.applyLogCompr = 0;
paramCP.inputFeatureRate = sideinfo.pitch.featureRate;
[f_chroma,sideinfo] = pitch_to_chroma(f_pitch,paramCP,sideinfo);
% plot the chromagram
seg_num = size(f_chroma,2);
chromatime = (1:seg_num)/sideinfo.chroma.chromaFeatureRate;
chroma = [1:12];
makeSubplot(224, chromatime, chroma, f_chroma, 'Chromagram','Chromagram frames (sec)','Chroma (pitch classes)');

function makeSubplot(subplotNum,xVec,yVec,matrix,header,xlab,ylab)
subplot(subplotNum)
imagesc(xVec,yVec,matrix);
title(header)
xlabel(xlab);
ylabel(ylab);
axis xy;