% function res=inClassFunction(matVals)
%
% matVals - a matrix of values
% res - a cell array of the rows in the input matrix

function res=inClassFunction(matVals)

for row = 1 : size(matVals,1)
    fname=getFname(row);
    res.(fname)=matVals(row,:);
end

function fname=getFname(row)
    fname=['rowNum' num2str(row)];
