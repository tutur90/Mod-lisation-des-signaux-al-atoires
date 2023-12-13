pkg load io
pkg load signal

F = 1e4;
N = 1024;

voise = {'193309__margo-heston__ooo',
         '193319__margo-heston__oo',
         '193310__margo-heston__nng'
         };
Vind = [7000 7000 7000];
         
nonvoise = {'193323__margo-heston__kss',
            '193320__margo-heston__th',
            '193311__margo-heston__hw',
            '193305__margo-heston__ch'
            };
NVind = [6500 5800 5300 6000];
            
% non voise
for i = 1:numel(nonvoise)
  [s,Fe] = audioread([nonvoise{i} '.flac']);
  s = s(:,1);
  [b,a] = butter(10, F/Fe);
  s = filter(b,a,s);
  S = fft(s);
  f = mod((0:numel(s)-1)*Fe/numel(s)+Fe/2,Fe)-Fe/2;
  S(abs(f)>F) = 0;
  s = real(ifft(S));
  s1 = resample(s,F/10,Fe/10);
  s1 = s1(NVind(i)+(0:N-1));
  s1 = s1-mean(s1);
  s1 = s1/max(abs(s1));
  audiowrite(sprintf('nonvoise_%s.flac',nonvoise{i}(23:end)),s1,F);
end

% voise
for i = 1:numel(voise)
  [s,Fe] = audioread([voise{i} '.flac']);
  s = s(:,1);
  [b,a] = butter(10, F/Fe);
  s = filter(b,a,s);
  S = fft(s);
  f = mod((0:numel(s)-1)*Fe/numel(s)+Fe/2,Fe)-Fe/2;
  S(abs(f)>F) = 0;
  s = real(ifft(S));
  s1 = resample(s,F/10,Fe/10);
  s1 = s1(Vind(i)+(0:N-1));
  s1 = s1-mean(s1);
  s1 = s1/max(abs(s1));
  audiowrite(sprintf('voise_%s.flac',voise{i}(23:end)),s1,F);
end