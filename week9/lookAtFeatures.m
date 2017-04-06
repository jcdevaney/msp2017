function res=lookAtFeatures(w,numFeatures)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% res=lookAtFeatures(w,numFeatures)
%
% Description: Investigate features for the Ave Maria svm
%
% (c) copyright 2015, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vals=sum(w);

[x,y,v]=find(w);
for i = 1 : numFeatures
    tmp=vals(i:numFeatures:end);
    res(i)=nnz(tmp);
end