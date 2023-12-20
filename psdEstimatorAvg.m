function [PSD, nu] = psdEstimatorAvg(X, Nfft, K)
    % Power spectral density estimator with segment averaging.
    %
    % INPUTS
    % - X: Vector of signal samples.
    % - Nfft: Number of signal samples to be considered in the FFT.
    % (Optional argument, defaults to twice the length of X)
    % - K: Number of segments for averaging (optional).
    %
    % OUTPUTS
    % - PSD: Vector of averaged PSD estimates for normalized frequency varying
    % from 0 to 1/2.
    % - nu: Vector of corresponding normalized frequency values.

    if nargin < 2
        Nfft = 2 * length(X);
    end

    if nargin < 3
        K = 1;
    end

    [Cx , pb] = BiasedCrossCorr(X, length(X));
    PSD2 = fft(Cx, Nfft);
    nu2= (0:(Nfft-1))/Nfft;
    nu = nu2(1:(length(nu2)/2));
    PSD = PSD2(1:length(PSD2)/2);
    PSD = PSD * length(X);

    PSD = movmean(PSD, K);


end
