% getMelFilterbanks
% compute triangular mel filterbanks
% cant: number of filterbanks (default 26)
% fs: sampling frecuecy (default 8000)
% high: upper frecuency limit in Hz (default fs/2)
% low: lower frecuency limit in Hz (default 0)
% binSize: fft bin size (default 512)


function H = getMelFilterbanks(cant=26, fs=8000, high=fs/2, low=0, binSize=512)

	% trasform limits to mel scale
	mels = mel([high,low]);
	
	step = (mels(1) - mels(2))/(cant + 2);

	m = [mels(2)  : step : mels(1)];
	
	% trasform back to Hz
	h = melInv(m);
	
	% round frecuecies to fft bin numbers
	f = floor((binSize + 1) * h / fs);
	
	H =  zeros(binSize,cant);


	% compute triangular filterbanks /\
	% the first filterbank starts at the first point reaches its peak
	% in the second point and return to zero at the third point
	% second filterbank starts at the second point reaches its peak
	% in the third point and returns to zero at the fourth point and
	% so on
	for m = 2 : cant + 1
	
		for k = 1 : binSize
			if (f(m-1) <= k && k <= f(m))
				H(k,m-1) = (1.0)*(k - f(m-1)) ...
					/(f(m) - f(m-1));
			else if (f(m) <= k && k <= f(m+1))
				H(k,m-1) = (1.0)*(f(m+1) - k) ...
					/(f(m+1) - f(m));
			     end
			end

		end
	end


end

