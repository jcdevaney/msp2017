%function inClassFunction2(filename,structure)
%
% Example function of passing a structure into the function 
% and providing default values if the structure is not passed in
% or the field is missing

function inClassFunction2(filename,structure)

if nargin > 1
    if isfield(structure,'sr')
        sr=structure.sr;
    else
        sr=44110;
    end
else
    sr=22055;
end

sprintf('This is the filename: %s. And this is the sr: %d.',filename, sr)