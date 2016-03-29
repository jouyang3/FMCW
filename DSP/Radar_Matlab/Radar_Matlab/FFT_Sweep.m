% This code produces the test input vectors to the FFT module

fs = 10e6/8; %10/8MHz Sampling Rate
N = 1024; %Sampling Size
n = 0:N-1;
T = 1/fs; 
t = n*T; 
F = linspace(10e3, 100e3); %10kHz to 100kHz with 1kHz steps

%Writing the input vector to a file
file = fopen('FFT_Sweep','w');
A = 2048/20;
%x is a single frequency sinusoidal signal
for f=F
    %FFT module takes in 12bit binary values
    x = round(A * cos(2 * pi * f * t));
    X_mag = abs(fftshift(fft(x)));
    X = round(X_mag);


    fwrite(file, X, 'uint16', 'ieee-be');
end


fclose(file);

