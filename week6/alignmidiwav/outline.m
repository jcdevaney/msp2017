function outline(M, V, C)
% outline(M, V, C)
%    M is an array.  Plot a manhattan-style outline in color C ('r')
%    at the contour of value V (0) in the plot.
% 2005-07-29 dpwe@ee.columbia.edu for broadclass paper

if nargin < 2;   V = 0; end
if nargin < 3;   C = 'r'; end

% Do it by row

[nr, nc] = size(M);

% append zeros at the end
M = [M;zeros(1,nc)];

hold on;

prvmsk = zeros(1, nc+2);

for r = 1:nr+1
  
  % Find the limits of V in this row, and find their overlap with 
  % limits from the prev row
  
  msk = [0, (M(r,:) > V), 0];
  
  up = find(msk(2:end) > msk(1:end-1))-.5;
  dn = find(msk(1:end-1) > msk(2:end))-.5;
  segs = [up',dn'];
  
  nsegs = size(segs, 1);
  
  % Where values this row begin and end, there will be vertical bars
  xxs = [segs(:)';segs(:)'];
  yys = repmat([r-.5;r+.5], 1, 2*nsegs);
  plot(xxs, yys, C);
%  plot([segs(:);segs(:)], repmat([r-1;r], 1, 2*nsegs), C);
  
  % Where this row differs from the prev row, there will be a horiz 
  % bar between them
  dif = msk ~= prvmsk;
  up = find(dif(2:end) > dif(1:end-1))-.5;
  dn = find(dif(1:end-1) > dif(2:end))-.5;
  segs = [up',dn'];
  plot(segs', repmat([r-.5;r-.5], 1, size(segs, 1)), C);
 
  prvmsk = msk;

end

hold off
