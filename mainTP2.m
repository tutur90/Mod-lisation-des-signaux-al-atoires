clear all;
close all;

N = 1024;
sigma_b = 0.92;
a = 0.7;

noise = genWhiteNoise(0.5, N);
AR1 = filter([1, 1-a],1, noise);
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

K = 4;

[PSD_noise, nu_noise] = psdEstimatorAvg(bccSig, N, K);
[PSD_ar1, nu_ar1] = psdEstimatorAvg(bccAr1, N, K);
[PSD_sin, nu_sin] = psdEstimatorAvg(bccSin, N, K);

% [PSD2_noise, nu2_noise] = psdEstimatorPeriodogram(noise, N);
% [PSD2_ar1, nu2_ar1] = psdEstimatorPeriodogram(AR1, N);
% [PSD2_sin, nu2_sin] = psdEstimatorPeriodogram(sin, N);

[PSD2_noise, nu2_noise] = psdEstimator(bccSig, N);
[PSD2_ar1, nu2_ar1] = psdEstimator(bccAr1, N);
[PSD2_sin, nu2_sin] = psdEstimator(bccSin, N);



n = linspace(0,N,N);



% figure(3)
% subplot(3, 1, 1); 
% plot(n, noise); 
% title('noise'); 

% subplot(3, 1, 2);
% plot(n, AR1); 
% title('AR1'); 

% subplot(3, 1, 3); 
% stem(n, sin); 
% title('sinusoid');


figure(2)
subplot(3, 1, 1); 
plot(nu_noise, PSD_noise, nu2_noise, PSD2_noise); 
title('noise'); 
legend('moyenne', 'non moyenne');
xlabel('Frequence reduite Nu');
ylabel('Estimation de la PSD');

subplot(3, 1, 2);
plot(nu_ar1, PSD_ar1, nu2_ar1, PSD2_ar1); 
title('AR1'); 
legend('moyenne', 'non moyenne');
xlabel('Frequence reduite Nu');
ylabel('Estimation de la PSD');

subplot(3, 1, 3); 
plot(nu_sin, PSD_sin, nu2_sin, PSD2_sin); 
title('sinusoid');
legend('moyenne', 'non moyenne');
xlabel('Frequence reduite Nu');
ylabel('Estimation de la PSD');


