function dct = discreteCosineTransform(melLogCoefs)

	K = length(melLogCoefs);
	C = zeros(1, K);
	for n = 1 : K
		for k = 1 : K
			C(n) += melLogCoefs(k) * cos(n * (k - 1/2) * pi/K);
		end
	end
	dct = C;
end
