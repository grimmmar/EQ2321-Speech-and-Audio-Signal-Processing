function s = synthesis4(E, ZC, V, A, P, ulen)
n_frames = size(A,1); % Assuming filter coefficients are stored row-wise
% Create noise excitation:
nexc = randn(n_frames*ulen, 1);
n1 = 1;
n2 = ulen;
Z = [];
E2 = zeros(n_frames, 1);
s = zeros(n_frames*ulen,1);
count = 0;

for n=1:n_frames
% Filter the excitation through the production (vocal tract) filter:
    if V(n)==1
        while count < P(n)
            count = count + 1;
        end
        cp=P(n);
        pexc=zeros(n_frames*ulen,1); 
        pexc(1:cp:end)=1;
        [s(n1:n2),Z]=varifilter(1,A(n,:),pexc(n1:n2),Z);
    else
        [s(n1:n2),Z]=varifilter(1,A(n,:),nexc(n1:n2),Z);
    end
    sum = 0;
    for i = n1:n2
        sum = sum + s(i)^2;
    end
    E2(n) = sum/ulen;
    s(n1:n2)=s(n1:n2)*sqrt(E(n)/E2(n));
    
    n1 = n1+ulen;
    n2 = n2+ulen;
    count = 0;
end
end