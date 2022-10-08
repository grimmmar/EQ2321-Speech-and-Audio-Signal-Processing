clc;
clear;
load assignment1.mat;
% Problem 3.1
Fs = 8000;
t = 1/Fs:1/Fs:length(male_short)/Fs;
figure(1);
plot(t,male_short);
xlabel('Time/s');
ylabel('Amplitude');
title('Time plot of male short');

% Problem 3.3
N = 240; % t from 0.25 to 0.28,n from 2000 to 2239
S = 2000;
xf1 = male_short(S:S+N-1).*hanning(N);
X1 = fft(xf1);
f = 0:4000/121:4000*120/121; % frequency of at x is x*4000/121,convert the point into frequency
figure(2); 
plot(f,10*log10(abs(X1(1:N/2+1)).^2));
title('Spectrum for a voiced frame(hanning window)');
xlabel('Frequency/Hz');
ylabel('Power/dB');
% Problem 3.8
M = 10; % M is the prediction order
c1 = xcorr(xf1, xf1, M);
[a1,e1]= levinson(c1(M+1:2*M+1)); % a is a vector always starting with a=1.
a1 = a1(:); % Make a a column vector
h1 = zeros(N,1);
for k=0:N-1
    h1(k+1) = 1 / (a1'*exp(-1i*2*pi*k/N*(0:M)') );
end
hold on;
plot(f,10*log10(e1*abs(h1(1:N/2+1)).^2), 'r');

% Problem 3.7
xf2 = male_short(S:S+N-1);
X2 = fft(xf2);
figure(3); 
plot(f,10*log10(abs(X2(1:N/2+1)).^2));
title('Spectrum for a voiced frame(recrangular window)');
xlabel('Frequency/Hz');
ylabel('Power/dB');
% Problem 3.8
c2 = xcorr(xf2, xf2, M);
[a2,e2]= levinson(c2(M+1:2*M+1)); % a is a vector always starting with a=1.
a2 = a2(:); % Make a a column vector
h2 = zeros(N,1);
for k=0:N-1
    h2(k+1) = 1 / (a2'*exp(-1i*2*pi*k/N*(0:M)') );
end
hold on;
plot(f,10*log10(e2*abs(h2(1:N/2+1)).^2), 'r');