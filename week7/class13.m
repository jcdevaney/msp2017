% example of subplotting with changing variables
for i = 1 : 16
    subplot(4,4,i)
    pause
end

% to get the last value in a vector
t=1:10;
t(end)
% or second to las
t(end-1)

% to reserve a vector you can use end or fliplr
t(end:-1:1)
fliplr(t)

% loudness
% Loudness_Validation script

% instead of running this code...
% [x,sr]=wavread('avm.wav');
% labels=load('avm-fixed.txt');
% for i = 1 : size(labels,1)
%     % get loudness estimate for time-vaying sounds based on Glasberg and
%     % Moore (2002)
%     loudnessStructure_TV_Moore{i}=Loudness_TimeVaryingSound_Moore(x(labels(i,1)*sr:labels(i,2)*sr),sr);
%     loudnessStructure_TV_Zwicker{i}=Loudness_TimeVaryingSound_Zwicker(x(labels(i,1)*sr:labels(i,2)*sr),sr);
% end
% ... just load the variables
load 'loudness.mat'

figure(1)
subplot(211)
imagesc(loudnessStructure_TV_Zwicker{1}.time,loudnessStructure_TV_Zwicker{1}.frequency,loudnessStructure_TV_Zwicker{1}.InstantaneousSpecificLoudness)
title('Instantaneous Specific Loudness (Zwicker)')
ylabel('Frequency (Hz)')
xlabel('Time (Seconds)')
axis xy
subplot(212)
imagesc(loudnessStructure_TV_Moore{1}.time,loudnessStructure_TV_Moore{1}.frequency,loudnessStructure_TV_Moore{1}.InstantaneousSpecificLoudness)
axis xy
title('Instantaneous Specific Loudness (Moore)')
ylabel('Frequency (Hz)')
xlabel('Time (Seconds)')

figure(2)
subplot(211), plot(loudnessStructure_TV_Zwicker{1}.time,loudnessStructure_TV_Zwicker{1}.InstantaneousLoudness)
title('Instantaneous Loudness (Zwicker)')
ylabel('Frequency (Hz)')
xlabel('Time (Seconds)')
subplot(212), plot(loudnessStructure_TV_Zwicker{1}.time,loudnessStructure_TV_Zwicker{1}.InstantaneousLoudnessLevel)
title('Instantaneous Loudness (Moore)')
ylabel('Frequency (Hz)')
xlabel('Time (Seconds)')