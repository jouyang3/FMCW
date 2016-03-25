% This code produces the test input vectors to the FFT module

fs = 1 * 10^6; %1MHz Sampling Rate
N = 2048; %Sampling Size
n = 0:N-1;
T = 1/fs; 
t = n*T; 
Frequency = 50 * 10^3; %50kHZ

%x is a single frequency sinusoidal signal
x = round(4095/6 * cos(2 * pi * Frequency * t) + 4095/6);
subplot(2,1,1);
plot(t,x)
title('Input signal');

%Writing the input vector to a file
file = fopen('FFT_Input.txt','w');

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




