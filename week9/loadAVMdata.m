function [avmP,avmNP]=loadAVMdata(genMat,loudMat,pSingers,npSingers,versions)

% load and consolidate pitch and timing Ave Maria data with loudness data
% for the specified professional and non-professional singers and versions

load(genMat)
load(loudMat)

% % Calculate pitch-related values for each note
%proVals=[];
%npVals=[]; 
proVals=amAnalysis(pSingers,versions,avmYINp,labsP,44100);
npVals=amAnalysis(npSingers,versions,avmYINnp,labsNP,44100);

% % Extract intervals and dct values from the proVals and npVals structures
avmP=extractAVvals(proVals,pSingers,versions, 0, 'p');
avmNP=extractAVvals(npVals,npSingers,versions, 0, 'np');

for i = 1 : length(versions)
    for j = 1 : length(pSingers)
        timesP{j,i}=labsP{pSingers(j),i}-labsP{pSingers(j),i}(1,1);
        ioisP{j,i}=diff(timesP{j,i}(:,1));
        avmP.AVtimes{j}(i,:)=timesP{j,i}(:,2)-timesP{j,i}(:,1);
        avmP.AVioi{j}(i,:)=[0 ioisP{j,i}'];

        timesNP{j,i}=labsNP{npSingers(j),i}-labsNP{npSingers(j),i}(1,1);
        ioisNP{j,i}=diff(timesNP{j,i}(:,1));
        avmNP.AVtimes{j}(i,:)=timesNP{j,i}(:,2)-timesNP{j,i}(:,1);
        avmNP.AVioi{j}(i,:)=[0 ioisNP{j,i}'];
    end
end

load avmLoudness.mat

num = 1; 
for s = pSingers
    for v = 1 : length(versions)
        for k = 1 : 76
            avmP.AVLTLmax{num}(v,k)=avmLoudnessPvals{s,v}(k).LTLmax; 
        end
    end
    num=num+1; 
end

num = 1;
for s = npSingers
    for v = 1 : length(versions)
        for k = 1 : 76
            avmNP.AVLTLmax{num}(v,k)=avmLoudnessNPvals{s,v}(k).LTLmax; 
        end
    end
    num=num+1; 
end

notes{1}=(1:6);
notes{2}=(71:76);