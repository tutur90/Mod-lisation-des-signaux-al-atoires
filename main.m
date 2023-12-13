clear all;
close all;

N = 256;
sigma_b = 0.92;
a = 0.92;

noise = genWhiteNoise(0.5, N);
AR1 = filter(1, 1-a, noise);
sin = genVarSine(100, 1000,256);

bccSig = BiasedCrossCorr(noise, N-1);
bccAr1 = BiasedCrossCorr(AR1, N-1);
bccSin = BiasedCrossCorr(sin, N-1);

ubccSig = UnbiasedCrossCorr(noise, N-1);
ubccAr1 = UnbiasedCrossCorr(AR1, N-1);
ubccSin = UnbiasedCrossCorr(sin, N-1);


var_sin = var(sin);
var_ar1 = var(AR1);
var_noise = var(noise);

[voise,fs1] = audioread("data/193309__margo-heston__ooo.flac");
[nonvoise,fs2] = audioread("data/193305__margo-heston__ch.flac");
t1=linspace(0,length(voise)/fs1,length(voise));
t2=linspace(0,length(nonvoise)/fs2,length(nonvoise));

v1 = BiasedCrossCorr(voise, length(voise)-1);
v2 = BiasedCrossCorr(nonvoise, length(nonvoise)-1);


isVoiced(v1, fs1);


[PSDk_noise, nuk_noise] = psdEstimator(bccSig, N, 8);


[PSD_noise, nu_noise] = psdEstimator(bccSig, N, 8);
[PSD_ar1, nu_ar1] = psdEstimator(bccAr1, N, 8);
[PSD_sin, nu_sin] = psdEstimator(bccSin, N, 8);

% figure(4)
% subplot(2, 1, 1); 
% plot(t1, voise); 
% title('voise'); 
% 
% subplot(2, 1, 2);
% plot(t2,nonvoise)
% title('non voise'); 


% figure(5)
% subplot(2, 1, 1); 
% plot(getLineSpace(v1, fs1), v1); 
% title('voisé'); 
% 
% subplot(2, 1, 2); 
% plot(getLineSpace(v2, fs2), v2); 
% title('non voisé'); 


% 
% n = linspace(0,N,N);
% 
% figure(1);
% 
% subplot(3, 1, 1); 
% plot(n, bccSig); 
% title('BiasedCrossCorr white noise'); 
% 
% 
% subplot(3, 1, 2);
% plot(n, bccAr1); 
% title('BiasedCrossCorr AR1'); 
% 
% 
% subplot(3, 1, 3); 
% plot(n, bccSin); 
% title('BiasedCrossCorr sinusoid'); 
% 
% figure(2);
% 
% 
% subplot(3, 1, 1); 
% plot(n, ubccSig); 
% title('UnbiasedCrossCorr white noise'); 
% 
% 
% subplot(3, 1, 2);
% plot(n, ubccAr1); 
% title('UnbiasedCrossCorr AR1'); 
% 
% 
% subplot(3, 1, 3); 
% plot(n, ubccSin); 
% title('UnbiasedCrossCorr sinusoid');
% 
% figure(3)
% subplot(3, 1, 1); 
% plot(n, noise); 
% title('noise'); 
% 
% subplot(3, 1, 2);
% plot(n, AR1); 
% title('AR1'); 
% 
% subplot(3, 1, 3); 
% stem(n, sin); 
% title('sinusoid');


figure(6)
subplot(3, 1, 1); 
plot(nu_noise, PSD_noise); 
title('noise'); 

subplot(3, 1, 2);
plot(nu_ar1, PSD_ar1); 
title('AR1'); 

subplot(3, 1, 3); 
plot(nu_sin, PSD_sin); 
title('sinusoid');


[PSD2_noise, nu2_noise] = psdEstimatorPeriodogram(noise, N);
[PSD2_ar1, nu2_ar1] = psdEstimatorPeriodogram(AR1, N);
[PSD2_sin, nu2_sin] = psdEstimatorPeriodogram(sin, N);


figure(7)
subplot(3, 1, 1); 
plot(nu2_noise, PSD2_noise); 
title('noise'); 

subplot(3, 1, 2);
plot(nu2_ar1, PSD2_ar1); 
title('AR1'); 

subplot(3, 1, 3); 
plot(nu2_sin, PSD2_sin); 
title('sinusoid');



% Find peaks in the signal  
[peaks1, locations1] = findpeaks(v1);  
[peaks2, locations2] = findpeaks(v2);  

figure(10) 
subplot(2,1,1); 
hold on; 
plot(t1, v1);  
scatter(t1(locations1), peaks1, 'r', 'filled');  
disp(mean(diff(t1(locations1)))) 
disp(mean(diff(t2(locations2)))) 
xlabel('Time');  
ylabel('Amplitude');  
title('Signal with Peaks voise');  
hold off; 
subplot(2,1,2); 
hold on; 

[a,v] = YuleWalkerSolver(ubccSig,length(ubccAr1)-1)


