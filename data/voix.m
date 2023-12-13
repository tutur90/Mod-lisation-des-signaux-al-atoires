pkg load io
pkg load signal

F = 1e4;

fichier = {'coctEx'
         };
         
Find = 1*[1 1];

for i = 1:numel(fichier)
  [s,Fe] = audioread(sprintf('%s.aiff',fichier{i}));
  s = s(Find(i):end,1);
  f = mod((0:numel(s)-1)*Fe/numel(s)+Fe/2,Fe)-Fe/2;
  [b,a] = butter(10, F/Fe);
  s = filter(b,a,s);
  S = fft(s);
  %figure;plot(f(abs(f)<Fe/2),20*log10(abs(S(abs(f)<Fe/2))));
  S(abs(f)>F/2) = 0;
  s = real(ifft(S));
  s1 = resample(s,F/10,Fe/10);
  s1 = s1-mean(s1);
  s1 = s1/max(abs(s1));
  %figure;plot(20*log10(abs(fft(s1))));
  audiowrite(sprintf('%s.flac',fichier{i}),s1,F);
end
