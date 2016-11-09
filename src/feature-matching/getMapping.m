function Q = getMapping(codebook,data)
		M = length(data(:,1));
		N = length(codebook(:,1));
		for m = 1 : M
				Q(m) = 1;
				mn = norm(codebook(1,:) - data(m,:)).^2;
				for n = 2 : N
					err = norm(codebook(n,:) - data(m,:))^2;
					if err < mn
						mn = err;
						Q(m) = n;
					end
				end
		end

	
end

