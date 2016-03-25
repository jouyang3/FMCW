clear;

%open the file that contains the serial module outputs
file = fopen('Serial_output_final.txt','r');
X_mag = fscanf(file, '%d');

fs = 10*10^6 / 8;
N = 2048;

%another way to scan the file
%{
for i = 1:4096
    X(i) = str2num(fgetl(file));
end
%}

plot((1:length(X_mag))*fs/N , X_mag)
title('Frequency spectrum received from serial Module');

fclose(file);
