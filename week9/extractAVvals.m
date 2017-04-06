function res=extractAVvals(AVvals,ss,vv,file,fileext)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% res=extractAVvals(AVvals,ss,vv,file,fileext)
%
% Description: Extract data from inputted Ave Maria mat file
%
% (c) copyright 2011, Johanna Devaney (j@devaney.ca)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~exist('file', 'var'), file = 0; end
if ~exist('fileext', 'var'), fileext = ''; end

% Extract intervals and write intervals to a file
num = 1;
for sP = ss
    AVints=[];
    for v = vv
        AVintsRM(v,1:size(([AVvals.robustmean{sP,v,:}]),2))=getAVInts([AVvals.robustmean{sP,v,:}]); 
        AVdirftRM(v,1:size(([AVvals.robustmean{sP,v,:}]),2))=[AVvals.robustmean{sP,v,:}]*1200-AVvals.robustmean{sP,v,1}*1200;
        AVfirstNoteRM(v,1:size(([AVvals.robustmean{sP,v,:}]),2))=AVfirstNoteDiff([AVvals.robustmean{sP,v,:}]); 
        AVfirstNote(v,1:size(([AVvals.ppitch{sP,v,:}]),2))=AVfirstNoteDiff([AVvals.ppitch{sP,v,:}]);
        AVints(v,1:size(([AVvals.ppitch{sP,v,:}]),2))=getAVInts([AVvals.ppitch{sP,v,:}]);        
        AVdrift(v,1:size(([AVvals.ppitch{sP,v,:}]),2)) = [AVvals.ppitch{sP,v,:}]*1200-AVvals.ppitch{sP,v,1}*1200;
        for i = 1 : size(AVvals.dct,3)
            try
                AVdcts(v,i)=AVvals.dct{sP,v,i}(2); 
                AVdctsMA(v,i)=AVvals.dctMA{sP,v,i}(2);  
                AVcurve(v,i)=AVvals.dct{sP,v,i}(3); 
                AVcurveMA(v,i)=AVvals.dctMA{sP,v,i}(3);  
                AVdepth(v,i)=AVvals.vibratoDepth{sP,v,i}; 
                AVrate(v,i)=AVvals.vibratoRate{sP,v,i}; 
            end
        end
    end
    res.AVints{num}=AVints;
    res.AVintsRM{num}=AVintsRM;
    res.AVfirstNote{num}=AVfirstNote;
    res.AVfirstNoteRM{num}=AVfirstNoteRM;
    res.AVdcts{num}=AVdcts;
    res.AVdctsMA{num}=AVdctsMA;
    res.AVcurve{num}=AVcurve;
    res.AVcurveMA{num}=AVcurveMA;
    res.AVdepth{num}=AVdepth;
    res.AVrate{num}=AVrate;
    num = num + 1;
    if file
        xlswrite(sprintf('AVintS%d%s',sP,fileext),AVints')
    end
end  

% num = 1;
% for sNP = ssNP
%     AVints=[];
%     for v = vv   
%         AVints(v,1:size(([npVals.ppitch{sNP,v,:}]),2)-1)=getAVInts([npVals.ppitch{sNP,v,:}]);
%     end
%     avmNP{num}=AVints;
%     num = num + 1;
%     if
%         xlswrite(sprintf('AVintS%dnp',sNP),AVints')
%     end
% end
