function phi=periodogramse(y,v,L)

% check the length of the window vector
M=length(v);
N=length(y);
if (M>N)
   error('The length of the window is larger than the length of the data vector');
   return
elseif (M<N),
   fprintf('WARNING:  The length of the window is smaller than the length\n')
   fprintf('          of the data vector; the data vector will be truncated\n')
   fprintf('          to the window length\n')
end

y=y(:);         % columlize the data matrix 
% generate the spectral estimate

phi=(abs(fft((y(1:M).*v(:)),L)).^2)/M;
