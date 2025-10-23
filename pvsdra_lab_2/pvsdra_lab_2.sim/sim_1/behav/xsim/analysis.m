[sound_old, fs_old] = audioread('');
[sound_new, fs_new] = audioread('');

figure;
    
nfft = 512;
window = hamming(nfft);
 
subplot(1,2,1);
specgram(sound_old, nfft, fs_old, window, 475);
set(gca,'Clim', [-65 15]);
xlabel('Время, с');
ylabel('Частота, гц');
title('Исходный');
colorbar;
    
subplot(1,2,2);
specgram(sound_new, nfft, fs_new, window, 475);
set(gca,'Clim', [-65 15]);
xlabel('Время, с');
ylabel('Частота, гц');
title('Результат');
colorbar;
