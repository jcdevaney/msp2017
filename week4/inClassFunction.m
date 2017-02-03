function res=inClassFunction(matVals)
% inClassFunction returns the individual rows in matVals
% as separate variables in the structure res
%   matVals - a matrix of values
%   res - a structure of the rows in the input matrix

for row = 1 : size(matVals,1)
    fname=getFname(row);
    res.(fname)=matVals(row,:);
end

function fname=getFname(row)
    fname=['rowNum' num2str(row)];
