% function [f0simp1, f0simp2, f0phase, f0yin] = f0estimation(filename)
% STFT-based F0 estimation
% Uses find_pitch_fft function from DAFX book
%  http://www2.hsu-hh.de/ant/dafx2002/DAFX_Book_Page/matlab.html

function [f0simp1, f0simp2, f0phase, f0yin] = f0estimation(filename)

[x,fs]=wavread(filename);
N = 1024;
win = N;
hop = floor(win/4);
f0min=50;
f0max=800;
fftthresh=1.05;
ltpthres=0.2;
lmin=floor(fs/f0max);
lmax=ceil(fs/f0min);
pre=lmax;

[S F T P] = spectrogram(x, win, win-hop, win, fs);

for frame = 1 : size(S,2)

    % STFT - largest bin
    f0simp1(frame)=f0estimatorFFT(abs(S(:,frame)),F,1);   

    % STFT - lowest bin after peak peaking of bin < 1/8th of max threshold
    f0simp2(frame)=f0estimatorFFT(abs(S(:,frame)),F,2);
   
    % STFT - lowest bin after peak peaking of bin < 1/8th of max threshold
    %        using phase information to refine central bin frequencies
    try
       % note the difference in changing minf0/maxf0/thresh values
       [FFTidx{frame}, Fp_est{frame}, Fp_corr{frame}]=find_pitch_fft(x(frame+hop*(frame-1):frame+hop*(frame-1)+win+hop), win, N, fs, hop, f0min, f0max, fftthresh);
    catch
       FFTidx{frame}=[];
       Fp_est{frame}=[];
       Fp_corr{frame}=[];
    end       
    if Fp_est{frame}
       f0phase(frame)=min(Fp_corr{frame});
    else
       f0phase(frame)=NaN;
    end

end

% run the YIN algorithm for "ground truth" F0 estimates
P.sr=fs;
P.thres=0.01;
P.hop=hop;
P.wsize=win;
yinStruct(frame)=yin(x,P);
f0yin=[yinStruct.f0];
f0yin=f0yin(1:size(f0simp1,2));

% plot the F0 estimates
figure(1)
f0subplot(f0simp1,f0yin,T,311,'Max Peak')
f0subplot(f0simp2,f0yin,T,312, 'Lowest Max Peak')
f0subplot(f0phase,f0yin,T,313, 'Lowest Max Peak using Phase Information')

function f0subplot(f0vals,yinVals,t,subplotNum,subtitle)

subplot(subplotNum)
plot(t,2.^yinVals*440,'r')
hold on
plot(t,f0vals,'b')
hold off
title(subtitle)
ylabel('Frequency (Hz)')
xlabel('Time (Sec)')
ylim([0 2000])