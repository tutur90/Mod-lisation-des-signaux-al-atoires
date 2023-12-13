clear all;

N = 256;
sigma_b = 0.5;
a = 0.92;



noise = genWhiteNoise(sigma_b, N);
AR1 = filter(1, 1-a, noise);
sin = genVarSine(100, 1000,256);

bccSig = BiasedCrossCorr(noise, N-1);
bccAr1 = BiasedCrossCorr(AR1, N-1);
bccSin = BiasedCrossCorr(sin, N-1);

ubccSig = UnbiasedCrossCorr(noise, N-1);
ubccAr1 = UnbiasedCrossCorr(AR1, N-1);
ubccSin = UnbiasedCrossCorr(sin, N-1);

var_noise = var(noise);
var_sin = var(sin);
var_ar1 = var(AR1);


[voise,fs1] = audioread("data/voise_ooo.flac");
[nonvoise,fs2] = audioread("data/nonvoise_ch.flac");
t1=linspace(0,length(voise)/fs1,length(voise));
t2=linspace(0,length(nonvoise)/fs2,length(nonvoise));

figure(4)
subplot(2, 1, 1); 
plot(t1, voise); 
title('voise'); 
% 
subplot(2, 1, 2);
plot(t2,nonvoise)
title('non voise');

 
[RVoise, lagVoise] = xcorr(voise, scale='unbiased'); 
[RNonVoise, lagNonVoise] = xcorr(nonvoise, scale='unbiased');


[PksVoise, LocVoise] = findpeaks(RVoise(1:length(RVoise)), "DoubleSided");
[PksNonVoise, LocNonVoise] = findpeaks(RNonVoise(1:length(RNonVoise)), "DoubleSided");

lagVoise = lagVoise/fs1;
lagNonVoise = lagNonVoise/fs2;

figure(5) 

subplot(2, 1, 1);  
hold on;
plot(lagVoise, RVoise); 
scatter(lagVoise(LocVoise), PksVoise)

title('voisé');  
hold off;
%  

subplot(2, 1, 2);  
hold on;
plot(lagNonVoise,RNonVoise);  
scatter(lagNonVoise(LocNonVoise), PksNonVoise)
title('non voisé'); 
hold off;

