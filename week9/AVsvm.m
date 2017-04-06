function [data, labels]=AVsvm(avm,fieldnames,versions,notes)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [data, labels]=AVsvm(avm,fieldnames,versions,notes)
%
% Description: Create data and labels to run libsvm on Ave Maria data
%
% (c) copyright 2015, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num=1;
for s = 1:6
    for v = versions
        tmpVec=[];
        for f = 1 : length(fieldnames)
            tmpVec=[tmpVec avm.(fieldnames{f}){s}(v,notes)];
        end
        data(num,:)=tmpVec;
        labels(num)=s;
        num=num+1;        
    end
end