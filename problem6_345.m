clc;
clear;
load assignment1.mat;
% Problem 6.3
x = male_short;
N = length(x);
Fs = 8000;
alen = 256;
% alen = 1024; % narrow-band
% alen = 64; % wide-band
ulen = 32;
naf = floor((N-alen+ulen)/ulen); % Number of analysis frames
n1 = 1;
n2 = alen;
S = zeros(alen/2+1, naf);
for n=1:naf % Counter over analysis frames
    xf_sp = x(n1:n2).*hanning(alen);
    % xf_sp = [xf_sp;zeros(alen,1)]; % zero-padding in wide-band
    % spectrogram
    X = fft(xf_sp);
    S(:,n) = 10*log10(abs(X(1:alen/2+1)).^2);
    n1 = n1 + ulen;
    n2 = n2 + ulen;
end
colormap(gray);
imagesc(0:N/(naf*Fs):N/Fs,0:4000/(alen/2+1):4000,flipud(-S));
yticklabels({'4000','3500','3000','2500','2000','1500','1000','500','0'});
xlabel('Time/s');ylabel('Frequency/Hz');
title('Spectrogram');
% title('Narrow-band spectrogram');
% title('Wide-band spectrogram');