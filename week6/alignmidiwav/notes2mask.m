function M = notes2mask(N,L,SR,NH,BN,WS,TF)
% M = notes2mask(N,L,SR, NH, BN, WS, TF)
%    N is a spectrogram-like array of note activity on a regular
%    time grid.  Convert this into a mask selecting the implicated 
%    harmonics on an FFT of length L at sampling rate SR.  Output 
%    mask M will be sizeof(N,2) columns and L/2+1 rows.  Optional 
%    NH is the number of harmonics to realize (default 8), and 
%    BN is the MIDI note number of the first row of N (default 1).
%    WS is the (minimum) width of the mask blocks in semitones (0.2)
%    TF is a tuning factor: midi-derived frequencies are scaled by 
%    this amount prior to matching (>1 = audio is sharp rel. to MIDI).
% 2008-03-19 Dan Ellis dpwe@ee.columbia.edu

if nargin < 2;   L = 1024;  end
if nargin < 3;   SR = 8000; end
if nargin < 4;   NH = 8; end
if nargin < 5;   BN = 1; end
if nargin < 6;   WS = 0.2; end
if nargin < 7;   TF = 1; end

% How wide (in semitones) is the window around each harmonic?
% (divide WS in two since it is applied both above and below ctr freq)
widthsemifactor = 2^((WS/2)/12);

noprows = (L/2)+1;

M = zeros(noprows,size(N,2));

for nrow = BN-1+[1:size(N,1)]
  note = BN-1+nrow;
  % MIDI note to Hz: MIDI 69 = 440 Hz
  freq = TF*(2.^(note/12))*440/(2^(69/12));
  if sum(N(nrow,:)) > 0
    mcol = zeros(noprows,1);
    for harm = 1:NH
      minbin = 1+floor(harm*freq/widthsemifactor/SR*L);
      maxbin = 1+ceil(harm*freq*widthsemifactor/SR*L);
      if minbin <= noprows
        maxbin = min(maxbin, noprows);
        mcol(minbin:maxbin) = 1;
      end
    end
    M(find(mcol),find(N(nrow,:))) = 1;
    %M = M | (mcol*N(nrow,:));
  end
end
