% getMapping
% maps the specified data into the codebook

% Q: mapping from data index to codebook index
% if the 1 data sample maps to the nth codevector then Q(1) = n;

function Q = getMapping(codebook,data)
		M = length(data(:,1));
		N = length(codebook(:,1));

		% iterate over data samples
		for m = 1 : M
				% find closest codevector 
				% initialize with first
				Q(m) = 1;
				% mn: min error
				mn = norm(codebook(1,:) - data(m,:)).^2;
				for n = 2 : N
					% err: mapping error
					err = norm(codebook(n,:) - data(m,:))^2;
					% if the curret mapping error is
					% less than the min error
					% update best mapping
					if err < mn
						mn = err;
						Q(m) = n;
					end
				end
		end

	
end

