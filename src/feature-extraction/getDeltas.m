% getDeltas
% compute dinamic coeficients 
% coefs: mel frecuency cepstral coeficients
% nCoefs: number of coeficient vectors
% N: number of frames to look back and foward
% function deltas = getDeltas(coefs, nCoefs, N)

function deltas = getDeltas(coefs,nCoefs,N)
	n = 1:N;
	deltas = zeros(nCoefs-N,length(coefs(1,:)));
	for t = N+1 : nCoefs
		deltas(t - N,:) = n*(coefs(t+n,:) - coefs(t-n,:)) ...
		/ 2 * (n * n');
	end
end
