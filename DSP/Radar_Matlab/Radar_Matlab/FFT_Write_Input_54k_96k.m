% This code produces the test input vectors to the FFT module

fs = 10 * 10^6; %10MHz Sampling Rate
N = 2048 * 8; %Sampling Size
n = 0:N-1;
T = 1/fs; 
t = n*T; 
Frequency1 = 54 * 10^3; %54kHZ
Frequency2 = 96 * 10^3; %96kHZ

%x is a sinusoidal signal
x = round((4095/10 * cos(2 * pi * Frequency1 * t) + 4095/10) + (4095/8 * cos(2 * pi * Frequency2 * t) + 4095/8));
subplot(2,1,1);
plot(t,x)
title('Input signal');

%Writing the input vector to a file
file = fopen('FFT_Input_54k_96k.txt','w');

%FFT module takes in 12bit binary values
binary_x = dec2bin(x,12);


for i = 1:length(x)
    fprintf(file, '%s\n', binary_x(i,:));
end

fclose(file);

%plotting the corresponding frequency spectrum
subplot(2,1,2);
X_mag = abs(fft(x));
plot(n * fs / N, X_mag);
title('FFT of the input signal generated from Matlab');
xlabel('Frequency (Hz)');




