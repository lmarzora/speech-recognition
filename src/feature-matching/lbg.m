function codeVector = lbg(training, epsilon,codeVectorCant)
	N = 1;
	M = length(training(:,1));
	k = length(training(1,:));
	
	codeVector(1,:) =  mean(training);
	Dstar  =  0;
	for m = 1 : M	
		Dstar += norm(training(m,:) - codeVector(1,:)).^2;
	end
	Dstar *= (1/M*k);
	i=0;
	while  N < codeVectorCant
	
	% SPLITTING
		for i = 1:N
			c(i,:) = (1+epsilon)*codeVector(i,:);
			c(N+i,:) =  (1-epsilon)*codeVector(i,:);
		end
	
		N = 2 * N;
		
		% ITERATION
		
		d = Dstar; 
		do
			D = d;
			Q = getMapping(c,training);
		
			for n = 1:N
				q = find(Q == n);
				c(n,:) = sum(training(q,:))./length(q);
			end
			d = getDistortion(c,training,Q);

		until (D - d)/D < epsilon
	
		Dstar = d;
		codeVector = c;
	end
end

