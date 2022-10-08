[fem_aud,Fs] = audioread('female44.wav');
Fc = 1000;
y = lowpass(fem_aud,Fc/Fs);
soundsc(y,Fs);