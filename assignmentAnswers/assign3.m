function res=assign3(filename,structure)

% The function  takes a filename (e.g., 'avmA.wav') and an optional 
% structure with the following (optional) fields: minF0 and maxF0 (for YIN) 
% and width and frameRate (for the Auditory toolbox functions). The default
% minF0 if it is not supplied is 220, the default maxF0 is 880, the default
% width is 256 and the default frameRate is 50. This  function supplies 
% default values if the optional structure (or one  of this fields) is not 
% passed in.

% check if the structure has been passed in and if all of the fields
% are present, if not assign default values
if nargin < 2
    structure.minf0=220;
    structure.maxf0=880;
    structure.width=256;
    structure.frameRate=50;
else
    if ~isfield(structure,'minf0')
        structure.minf0=220;
    end 
    if ~isfield(structure,'maxf0')
        structure.maxf0=880;
    end 
    if ~isfield(structure,'width')
        structure.width=256;
    end 
    if ~isfield(structure,'frameRate')
        structure.width=50;
    end 
end

% read the inputted file name as a wave file
[x,sr]=wavread(filename);

% run YIN
param.sr=sr;
param.minf0=structure.minf0;
yinVals=yin(x,sr);

% run the corrologram pitch estimator from the Auditory Toolbox
cor=CorrelogramArray(x',sr,structure.frameRate,structure.width);
p1=CorrelogramPitch(cor,structure.width,sr);

% run the corrologram pitch estimator from the Auditory Toolbox
% using Lyon's cochlear model
coch=LyonPassiveEar(x,sr,1,4,.5);
cor2=CorrelogramArray(coch,sr,structure.frameRate,structure.width);
p2=CorrelogramPitch(cor2,structure.width,sr);

% plot the results
figure(1)
ylimVals=[420 480];
t1=((1:length(yinVals.f0))/yinVals.sr*yinVals.hop);
t2=((1:length(p1))/structure.frameRate);
plotSubplot(1,t1,2.^yinVals.f0*440, 'YIN', 'Frequency (Hz)', 'Time (Sec)', ylimVals)
plotSubplot(2,t2,p1,'CorrelogramPitch','Frequency (Hz)','Time (Sec)',ylimVals);
plotSubplot(3,t2,p2,'CorrelogramPitch with Cochlear Model','Frequency (Hz)','Time (Sec)',ylimVals);

function plotSubplot(subplotVals,tVals,xVals,titleVal,ylabelVals,xlabelVals,ylimVals)
subplot(3,1,subplotVals)
plot(tVals,xVals)
title(titleVal)
ylabel(ylabelVals)
xlabel(xlabelVals)
ylim(ylimVals)