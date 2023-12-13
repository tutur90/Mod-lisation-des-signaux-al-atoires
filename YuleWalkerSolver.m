%% [a,v] = YuleWalkerSolver(Cx,K)
% Solves the Yule-Walker equations for a given cross-correlation
% sequence. This function can be used in two scopes:
% 1) finding optimized linear prediction coefficients at order K, such
% that: Xest(n+1) = a(1)*X(n) + a(2)*X(n-1) + ... + a(K)*X(n-K+1).
% Output v represents the minimal variance of prediction error.
% 2) fitting the parameters of an AR(K) process generated by
% X(n) = a(1)*X(n-1) + a(2)*X(n-2) + ... + a(K)*X(n-K) + W(n),
% where W is a white noise, called innovation, with variance v.
%
% INPUTS
% - Cx cross-correlation vector for lags 0 to K
% - K order ( optional argument, defaults to length(Cx)-1 )
% OUTPUTS
% - a vector of filter coefficients.
% - v prediction error variance or innovation power
function [a,v] = YuleWalkerSolver(Cx,K)

Gx = toeplitz(Cx(1:K))
Zx = Cx(2:K+1)

%Resolution de Gx.a = Cx
a =  Gx \ Cx(2:K+1);
%Calcul de la varaince à partir de la valeur p=0
v = Cx(1) - Cx(2:K+1)' * a;


end