% lbg
% computes a codeBook using the LBG vector quantization algorithm

% training: mel frecuency cepstral coeficients
% epsilon: codevector spliting parameter
% nCodeVectors: number of codevectors in codebook

function codebook = lbg(training, epsilon,nCodeVectors)
	% start with one codevector
	N = 1;
	M = length(training(:,1));
	k = length(training(1,:));

	% set codevector with average of etire training sequence
	codebook(1,:) =  mean(training);

	% Dstar = codebook average distortion
	Dstar  =  0;
	for m = 1 : M
		Dstar += norm(training(m,:) - codebook(1,:)).^2;
	end
	Dstar *= (1/(M*k));

	% loop until the amount of codevectors is reached
	i=0;
	while  N < nCodeVectors

		% SPLITTING
		% double amount of codevectors
		for i = 1:N
			c(i,:) = (1+epsilon)*codebook(i,:);
			c(N+i,:) =  (1-epsilon)*codebook(i,:);
		end

		N = 2 * N;

		% ITERATION
		% initial distortion
		d = Dstar;
		% iterate until the codebook converges
		do
			% D: previous step distortion
			D = d;
			% Q: mapping from training data to codevector
			% indexes
			Q = getMapping(c,training);

			for n = 1:N
				% q: indexes of training samples that
				% map to c(n)
				q = find(Q == n);
				% update codevector;
				c(n,:) = sum(training(q,:))./length(q);
			end
			% current step distortion
			d = getDistortion(c,training,Q);

		until (D - d)/D < epsilon

		% set new codebook distortion
		Dstar = d;
		% set new codebook
		codebook = c;
	end
end
