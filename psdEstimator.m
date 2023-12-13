function [PSD, nu] = psdEstimator(X, Nfft, K)
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

    segmentLength = floor(length(X) / K);
    PSD = zeros(Nfft/2 + 1, 1);

    for k = 1:K
        segmentStart = (k-1) * segmentLength + 1;
        segmentEnd = k * segmentLength;
        segment = X(segmentStart:segmentEnd);

        segmentPSD = fft(segment, Nfft);


        PSD = PSD + segmentPSD;
    end

    PSD = PSD / K;

    PSD = abs(PSD(1:Nfft/2 +1));
    nu = (0:Nfft/2) / Nfft;
end
