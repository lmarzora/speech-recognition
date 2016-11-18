% getDeltas
% compute dinamic coeficients
% coefs: mel frecuency cepstral coeficients
% N: number of frames to look back and foward
% returns deltas: dyamic coeficients
% function deltas = getDeltas(coefs, nCoefs, N)

function deltas = getDeltas(coefs,N)

	[nCoefs coefSize]= size(coefs);
	
	% copy first and last static coeficient
	leftPadding = repmat(coefs(1,:),N,1);
	rightPadding = repmat(coefs(end,:),N,1);

	% pad left and right
	coefs = [rightPadding;coefs;leftPadding];
	deltas = zeros(nCoefs,coefSize);

	% compute deltas
	for t = N+1 : coefSize + N
		up = zeros(1,coefSize);
		down = 0;
		for n = 1:N
			up += n*(coefs(t+n,:) - coefs(t-n,:));
			down += n^2;
		end
		deltas(t-N,:) = up/down;
	end

end


%	works
%	for t = N+1 : coefSize + Na
%		up = zeros(1,coefSize);
%		down = 0;
%		for n = 1:N
%			up += n*(coefs(t+n,:) - coefs(t-n,:));
%			down += n^2;
%		end
%		delta(t-N,:) = up/down;
%	end
%
%	wrong
%	for t = N+1 : nCoefs + N
%		deltas(t - N,:) = n*(coefs(t+n,:) - coefs(t-n,:)) ...
%		/ 2 * (n * n');
%	end
