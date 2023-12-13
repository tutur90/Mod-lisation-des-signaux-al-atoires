function y = genVarSine(f, fs, N)

    phi = 2 * pi * rand();

    t = (0:N-1) / fs;


    y = sin(2*pi*f*t +phi);
end
