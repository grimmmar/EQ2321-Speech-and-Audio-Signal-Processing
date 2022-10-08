function myspectrogram(x, alen, ulen)
% x is the speech vector
% alen is the analysis frame length, ulen is the update length
    N = length(x);
    naf = floor((N-alen+ulen)/ulen); % Number of analysis frames
    n1 = 1;
    n2 = alen;
    for n=1:naf % Counter over analysis frames
        xf = x(n1:n2);
        figure(1); 
        clf; 
        plot(xf); 
        axis([1 alen min(x) max(x)]); 
        pause(0.05);
        n1 = n1 + ulen;
        n2 = n2 + ulen;
    end
end
