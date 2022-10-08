[m_aud,Fs] = audioread('male44.wav');
Fc = 2000;
y = lowpass(m_aud,Fc/Fs);
soundsc(y,Fs);