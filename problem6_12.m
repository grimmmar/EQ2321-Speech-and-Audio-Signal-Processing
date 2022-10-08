clc;
clear;
load assignment1.mat;
% Problem 6.1&6.2
% myspectrogram(male_short, 256, 32);
x = male_short;
N = length(x);
Fs = 8000;
alen = 256;
ulen = 32;
naf = floor((N-alen+ulen)/ulen); % Number of analysis frames
n1 = 1;
n2 = alen;
for n=1:naf % Counter over analysis frames
    xf = x(n1:n2);
    t = n1/Fs:1/Fs:n2/Fs;
    figure(1); 
    clf; 
    subplot(2,1,1);
    plot(t,xf); 
    axis([n1/Fs n2/Fs min(x) max(x)]); 
    xlabel('Time/s');ylabel('Amplitude');
    title('Time domain');
    
    f = 0:4000/(alen/2+1):4000*(alen/2)/(alen/2+1);
    xf_sp = x(n1:n2).*hanning(alen);
    X = fft(xf_sp);
    subplot(2,1,2);
    plot(f,10*log10(abs(X(1:alen/2+1)).^2));
    xlabel('Frequency/Hz');ylabel('Power');
    title('Frequency domain');
    
    pause(0.05);
    n1 = n1 + ulen;
    n2 = n2 + ulen;
end