function res=AVfirstNoteDiff(ppitch)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% res=AVfirstNoteDiff(ppitch)
%
% Description: Return the different in cents between the first and
%              subsequent notes
%
% (c) copyright 2015, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AVallInt=diff(1200*ppitch);

res=(ppitch*1200)-(ppitch(1)*1200);