function [sig] = genWhiteNoise(sigma_b2, N)

sig = randn(1,N)*sqrt(sigma_b2);

end
   