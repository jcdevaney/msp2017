file1='ragtime';
file2='avm';

ragC = mirchromagram('ragtime', 'Frame');
avmC = mirchromagram('avm', 'Frame');
subplot(521)
ragCvals=mirgetdata(ragC);
imagesc(ragCvals)
title('Ragime (chroma)')
ylabel('Chroma')
axis xy
subplot(522)
avmCvals=mirgetdata(avmC);
imagesc(avmCvals)
axis xy
title('Ave Maria (chroma)')

ragM = mirmfcc('ragtime', 'Frame');
avmM = mirmfcc('avm', 'Frame');

subplot(523)
ragMvals=mirgetdata(ragM);
imagesc(1:length(ragMvals),2:13,ragMvals(2:13,:))
title('Ragime (mfccs)')
ylabel('MFCCs')
axis xy
figure(1)
subplot(524)
avmMvals=mirgetdata(avmM);
imagesc(1:length(avmMvals),2:13,avmMvals(2:13,:))
axis xy
title('Ave Maria (mfcss)')

ragS = mirspectrum('ragtime', 'Frame');
avmS = mirspectrum('avm', 'Frame');

subplot(525)
ragF=mirflux(ragS,'Frame');
ragFvals=mirgetdata(ragF);
plot(ragFvals)
xlim([0 size(ragFvals,2)])
ylim([0 200])
title('Ragtime (spectral flux)')
ylabel('Coefficient Value')
axis xy
figure(1)
subplot(526)
avmF=mirflux(avmS,'Frame');
avmFvals=mirgetdata(avmF);
plot(avmFvals)
xlim([0 size(avmFvals,2)])
ylim([0 200])
axis xy
title('Ave Maria (spectral flux)')

subplot(527)
ragB=mirbrightness(ragS,'Frame');
ragBvals=mirgetdata(ragB);
plot(ragBvals)
xlim([0 size(ragBvals,2)])
ylim([0.1 0.5])
title('Ragtime (brightness)')
ylabel('Coefficient Value')
axis xy
figure(1)
subplot(528)
avmB=mirbrightness(avmS,'Frame');
avmBvals=mirgetdata(avmB);
plot(avmBvals)
xlim([0 size(avmBvals,2)])
ylim([0.1 0.5])
axis xy
title('Ave Maria (brightness)')

subplot(529)
ragSC=mircentroid(ragS,'Frame');
ragSCvals=mirgetdata(ragSC);
plot(ragSCvals)
xlim([0 size(ragSCvals,2)])
title('Ragtimex (spectral centroid)')
ylabel('Coefficient Value')
xlabel('Frames')
axis xy
figure(1)
subplot(5,2,10)
avmSC=mircentroid(avmS,'Frame');
avmSCvals=mirgetdata(avmSC);
plot(avmSCvals)
xlim([0 size(avmSCvals,2)])
ylim([1000 2500])
axis xy
title('Ave Maria (spectral centroid)')
xlabel('Frames')

