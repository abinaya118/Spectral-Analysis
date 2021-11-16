function phi=btse(y,w,L)

M=length(w);
N=length(y);
if (M>N)
   error('The length of the window is longer than the data length.');
   return
end

% generate the covariance estimate
r=xcorr(y,'biased');    %vector of biased covariance estimates
r=r(N:N+M-1);           % get r(0) to r(M) only
    
rw = r(:).*w(:);        % the windowed ACS from 0 to M

% generate the spectral estimate

phi=2*real(fft(rw,L))-rw(1);    





