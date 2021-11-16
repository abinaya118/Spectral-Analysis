function phi=bartlettse(y,M,L)
% check the lenth M
N=length(y);
if (M>N)
   error('M is greater than the data length.');
   return
end

phi=welchse(y,ones(M,1),M,L);   % bartlett is a special case of welch.
