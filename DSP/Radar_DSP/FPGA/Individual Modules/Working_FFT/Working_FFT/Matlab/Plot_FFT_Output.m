%Reads in output of the FFT Module and plot the magnitude
fs = 1 * 10^6; %1MHz Sampling Rate
N = 2048; %Sampling Size

%open the output file
file = fopen('FFT_output.txt', 'r');

%the following loop reads in the complex data from FFT output
for i = 1:2048
    X(i) = bin2dec(fgetl(file));
end


plot((1:length(X)) * fs / N, X)
title('Frequency spectrum received from FFT Module');
xlabel('Frequency (HZ)');
fclose(file);

