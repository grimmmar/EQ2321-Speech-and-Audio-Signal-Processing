clc;
clear;
load assignment1.mat;

alen = 256;
ulen = 32;
x = male_long;
% x = female_long;
M = 10;
N = length(x);
naf = floor((N-alen+ulen)/ulen);
[E,ZC,V,A,P] = analysis(x,alen,ulen,M);

figure(1);clf;
subplot(3,2,1);
plot(x); % Plot the input waveform
axis([1 length(x) min(x) max(x)]);
title('Input Waveform');
subplot(3,2,2);
plot(sqrt(E)); % Plot the standard deviation
axis([1 length(E) min(sqrt(E)) max(sqrt(E))]);
title('Standard Deviation');
subplot(3,2,3);
plot(V); % Plot voiced/unvoiced decision
axis([1 length(V) 0 1]);
title('Voiced/unvoiced Decision');
subplot(3,2,4);
plot(ZC); % Plot the normalized number of zero-crossings
axis([1 length(ZC) min(ZC) max(ZC)]);
title('Normalized Number of Zero-crossings');
subplot(3,2,5);
F = 8000./P;
plot(F) % Plot the fundamental frequency in Hz
axis([1 length(F) 0 600]);
title('Fundamental Frequency(Hz)');
subplot(3,2,6);
S = zeros(512, naf);
for n=1:naf
    S(:,n) = 20*log10(abs(freqz(1,A(n,:),512)));
end
S = flipud(S);
colormap(gray);
imagesc(S); % Illustrate the vocal tract envelope in a spectrogram style!
title('Vocal Tract Envelope');