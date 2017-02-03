% function [autoCorrVal1,autoCorrVal2] = myAutocorr(vec,win)
% 
% Performs autocorrelation on an inputted vector (vec) with window size win.
% 
% autoCorrVal1 - running autocorrelation  vector calulated with nested for  
%                loops to illustrate the calulations in depth
% autoCorrVal2 - normalized version of running autocorrelation to
%                correspondent to results of non-windowed version (xcorr)
% autoCorrVal3 - output of the built in xcorr function
% -- only the positive lags are returned
%
% WARNING: The nested loops run very slowly
%
% Created by: Johanna Devaney

function [autoCorrVal1,autoCorrVal2,autoCorrVal3] = myAutocorr(vec,win)

if size(vec,1) > size(vec,2)
    vec=vec';
end

% zeropad inputted vector
vec2=[vec zeros(1,win)];

% calculate the autocorrelation directly
for tau = 0 : (length(vec2))
    for t = 1 : (length(vec2) - win - tau)
        autoCorrVal(t,tau+1)=(vec2(t:t+win-1)*vec2(t+tau:t+win-1+tau)')/win;
    end
end

%
autoCorrVal1=autoCorrVal(1,:);

% normalize the results
autoCorrVal2=sum(autoCorrVal,1)/max(sum(autoCorrVal,1));

% calcualte the autocorrelation with xcorr
autoCorrVal3=xcorr(vec,'coeff');
% remove the negative lags
autoCorrVal3=autoCorrVal3(ceil(length(autoCorrVal3)/2):end);

figure(1)
subplot(311)
plot(autoCorrVal1)
title('Running Autocorrelation') 
subplot(312)
plot(autoCorrVal2)
title('Calculated Autocorrelation - Windowed') 
subplot(313)
plot(autoCorrVal3)
title('xcorr Autocorrelation') 