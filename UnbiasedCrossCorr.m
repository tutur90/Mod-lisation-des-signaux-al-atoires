%% [Cx,p] = UnbiasedCrossCorr(X,pmax)
% Computation of the unbiased cross correlation of a given signal X.
%
% INPUTS
% - X vector of signal samples
% - pmax maximal amount of shift to be considered
% (optional, defaults to the length of X minus 1)
% OUTPUTS
% - Cx vector of cross correlation samples for shifts varying
% from 0 to pmax
% - p vector of corresponding shifts
function [Cx,p] = UnbiasedCrossCorr(X,pmax)
    Cx = zeros(1, pmax + 1);
    p = 0:pmax;

    for i = 0:pmax
        sum = 0;
        for j = 1:length(X) - i
            sum = sum + X(j) * X(j + i);
        end
        Cx(i + 1) = ( sum / length(X)) / (1 - (abs(p(i+1))/length(X)));
    end
end
