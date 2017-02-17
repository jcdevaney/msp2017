function D = samplemidi(MF,T,C,MX)
% D = samplemidi(MF,T,C,MX)
%    Return D as a 127x... piano roll matrix of notes in the MIDI
%    file named MF sampled at regularly-spaced times T sec apart
%    (default 0.05 s = 20 frames/sec), 
%    including all channels specified in C (default: all except
%    drums (10))
%    Optional MX is max duration of sustained notes in sec (default
%    5.0).  Setting to zero means no duration caps.
% 2008-03-18 Dan Ellis dpwe@ee.columbia.edu

if nargin < 2
  T = 0.05;
end
if nargin < 3
  C = [[1:9],[11:127]];
end
if nargin < 4
  MX = 5;
end

nmat = midi2nmat(MF);
% Make into CHAN MPITCH TSTART DUR
notes = nmat(:,[3 4 6 7]);
% Limit duration
if MX > 0
  notes(:,4) = min(MX, notes(:,4));
end
% Convert duration to end time
notes(:,4) = notes(:,3)+notes(:,4);

nnotes = size(notes,1);

% Remove unwanted notes
haveCs = unique(notes(:,1))';
keepnotes = zeros(1,nnotes);
for cc = haveCs;
  if sum(cc == C) > 0
    keepnotes = keepnotes | (notes(:,1)'==cc);
  end
end
notes = notes(keepnotes,:);

endtime = max(notes(:,4));

tt = 0:T:endtime;

nr = 127;
nc = size(tt,2);

D = zeros(nr,nc);

for i = 1:length(tt);
  tim = tt(i);
  nn = find((notes(:,3) <= tim) & (notes(:,4) > tim));
  % add into outputs
  D(notes(nn,2),i) = 1;
end
