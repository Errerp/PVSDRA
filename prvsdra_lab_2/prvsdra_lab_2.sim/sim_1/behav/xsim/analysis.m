fileID = fopen('y_out.hex', 'r');
data_hex = textscan(fileID, '%s');
fclose(fileID);

data_dec = hex2dec(data_hex{1});

N = 15; 
data_dec(data_dec >= 2^(N-1)) = data_dec(data_dec >= 2^(N-1)) - 2^N;

sound_new = double(data_dec) / 2^13;

[sound_old, fs] = audioread('sh_sound.wav');

sound_old = sound_old(:);
sound_new = sound_new(:);

audiowrite('sh_filtered.wav', sound_new, fs);

nfft = 512;
window = hamming(nfft);

figure;
subplot(1,2,1);
specgram(sound_old, nfft, fs, window, 475);
set(gca, 'Clim', [-65 15]);
xlabel('Время, с');
ylabel('Частота, Гц');
title('Исходный');
colorbar;

subplot(1,2,2);
specgram(sound_new, nfft, fs, window, 475);
set(gca, 'Clim', [-65 15]);
xlabel('Время, с');
ylabel('Частота, Гц');
title('Результат фильтра');
colorbar;
