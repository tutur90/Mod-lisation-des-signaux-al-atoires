% Power spectral density estimator.
    %
    % INPUTS
    % - X: Vector of signal samples.
    % - Nfft: Number of signal samples to be considered in the discrete
    % Fourier transform (FFT).
    % (Optional argument, defaults to twice the length of X)
    %
    % OUTPUTS
    % - PSD: Vector of PSD estimates for normalized frequency varying
    % from 0 to 1/2.
    % - nu: Vector of corresponding normalized frequency values.
function [PSD, nu] = psdEstimatorPeriodogram(X, Nfft)
    
    Xfft = fft(X, Nfft);
    PSD = (1/length(X))*abs(Xfft).^2;
    
    nu = (0:Nfft/2) / Nfft;

    PSD = PSD(1:Nfft/2 +1);
end