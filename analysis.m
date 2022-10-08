function [E,ZC,V,A,P] = analysis(x, alen, ulen,M)
% Initialization
N = length(x);
naf = floor((N-alen+ulen)/ulen); % Number of analysis frames
n1 = 1;
n2 = alen;
threshold = 0.3;

E = zeros(naf, 1);
ZC = zeros(naf, 1);
V = zeros(naf, 1);
A = zeros(naf, M+1);
P = zeros(naf, 1);

% Inside loop
for n=1:naf
    xf = x(n1:n2);
    sum = 0;
    for i = 1:alen
        sum = sum + xf(i)^2;
    end
    E(n) = sum/alen;
    n_zero = 0;
    for j = 2:alen
        if xf(j)*xf(j-1)<0
            n_zero = n_zero+1;
        end
    end
    ZC(n) = n_zero/alen;
    if ZC(n) < threshold
        V(n) = 1; % Voiced
    else
        V(n) = 0; % Unvoiced
    end
    c = xcorr(xf, xf, M);
    [a,~]= levinson(c(M+1:2*M+1)); % a is a vector always starting with a=1.
    a = a(:); % Make a a column vector
    A(n,:) = a;
    d = xcorr(xf, xf);
    d = d(alen:end);
    peaks = logical([0; (d(2:end-1) > d(1:end-2)) & (d(2:end-1) > d(3:end)); 0]);
    index = find(d == max(d(peaks)));
    P(n) = index;
    n1 = n1 + ulen;
    n2 = n2 + ulen;
end


