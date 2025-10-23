[sound, fs] = audioread('sh_sound.wav') ;

converted_sound = uint8(sound * 127 + 128); 
fid = fopen('sh_sound.hec', 'w');
fwrite(fid, converted_sound, 'uint8'); 
fclose(fid);

