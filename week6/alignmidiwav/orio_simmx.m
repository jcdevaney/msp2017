function S = orio_simmx(M,D)
% S = orio_simmx(M,D)
%    Calculate an Orio&Schwartz-style (Peak Structure Distance) similarity
%    matrix.  M is the binary mask (where each column corresponds
%    to a row in the output matrix S); D is the regular spectrogram,  
%    where columns of S correspond to columns of D (spectrogram time
%    slices).
%    Each value is the proportion of energy going through the 
%    mask to the total energy of the column of D, thus lies 
%    between 0 (no match) and 1 (mask completely covers energy in D
%    column).
% 2008-03-20 Dan Ellis dpwe@ee.columbia.edu

% Calculate the similarities

% vertical is midi time base, horizontal is audio
S = zeros(size(M,2),size(D,2));

% This way is slow
%for r = 1:size(M,2)
%  for c = 1:size(D,2)
%    nDc = norm(D(:,c));
%    nDc = nDc + (nDc==0);
%    S(r,c) = norm(D(:,c).*M(:,r))/nDc;
%  end
%end

% Doing it one row at a time is 60x faster (20.7s vs. 0.34s for 1000x1000)
D = D.^2;
M = M.^2;

nDc = sqrt(sum(D));
% avoid div 0's
nDc = nDc + (nDc == 0);

% Evaluate one row at a time
for r = 1:size(M,2)
  S(r,:) = sqrt(M(:,r)'*D)./nDc;
end
