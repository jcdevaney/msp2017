function [align,spec] = runDTWAlignment(audiofile, midifile, visualise, tres)

% This function run's Dan Ellis' DTW alignment code
% D. P. W. Ellis (2008). "Aligning MIDI scores to music audio", web resource. 
% http://www.ee.columbia.edu/~dpwe/resources/matlab/alignmidiwav/
%
% Written by: Johanna Devaney

if nargin < 3
  visualise = 0;
end

if nargin < 4
  tres = 0.025;
end

% run alignment using peak structure distance as a feature
[dtw.M,dtw.MA,dtw.RA,dtw.S,spec,dtw.notemask] = alignmidiwav(midifile,...
    audiofile,tres,1);

% read midi file and map the times in the midi file to the audio
nmat = midi2nmat(midifile);
nmat(:,7) = nmat(:,6) + nmat(:,7);
nmat(:,1:2) = maptimes(nmat(:,6:7),(dtw.MA-1)*tres,(dtw.RA-1)*tres);

% create output alignment 
align.on = nmat(:,1);
align.off = nmat(:,2);
align.midiNote = nmat(:,4);

if visualise
    imagesc(20*log10(spec));
    axis xy;
    caxis(max(caxis)+[-50 0])
    colormap(1-gray)
    outline(dtw.notemask(:,dtw.M),0,'r')
end