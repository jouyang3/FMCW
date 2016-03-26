fid = fopen('FFT_output_50k.txt','r');
X_mag = [];
tline = fgets(fid);
while ischar(tline)
    X_mag = [X_mag; tline];
    tline = fgets(fid);
end
fclose(file);

fid = fopen('FFT_output_50k_arduino.txt','w');


for ii=1:length(X_mag)/2
    sample = X_mag(ii,:);
    sampleUB = uint8(bin2dec(sample(1:4)));
    sampleLB = uint8(bin2dec(sample(5:12)));
    addr = 2*(ii-1);
    fprintf(fid, 'EEPROM.write(%d,%d);\n', addr, sampleUB);
    fprintf(fid, 'EEPROM.write(%d,%d);\n', addr + 1, sampleLB);
end

fclose(fid);
