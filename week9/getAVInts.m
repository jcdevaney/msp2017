function AVallInt=getAVInts(ppitch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AVallInt=getAVInts(ppitch)
%
% Description: Calculate intervals in cents from perceived pitch
%
% (c) copyright 2011, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AVallInt=diff(1200*ppitch);
AVallInt=[0 AVallInt];