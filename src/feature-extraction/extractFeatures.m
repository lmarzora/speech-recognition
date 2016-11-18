%  compute mel frecuency cepstral coeficients

% X: signal samples
% fs: sampling frecuency
% frameLength: duration in seconds of frame (default 0.025)
% frameStep: interval in secods between frames (default 0.010)
% nFilterbanks: number of filterbanks to use (default 26)
% minFrequency: lower filterbank frequecy limit in Hz (default 0)
% maxFrequency: upper filterbak frequecy limit i Hz (default fs/2)
% N: delta step (default 2)
% useDeltas: use dynamic coeficients (default 1);

function mfcc = extractFeatures(X, fs, frameLength = 0.025,
	frameStep = 0.010, nFilterbanks = 26, minFrequency = 0,
	maxFrequency = fs/2, N = 2, useDeltas = 2)

	pkg load signal

	#FRAME SIGNAL
	[frames frameSamples cantFrames] = ...
		frameSignal(frameLength,frameStep,X,fs);

	# WINDOW SAMPLE check mono
	% hamming window
	h = hamming(frameSamples)';

	% K: fast fourier transform bin size
	% find previous power of 2
	K = 2.^floor(log2(frameSamples));
	% K = 512;

	# COMPUTE MEL FILTERBANK
	filterbanks = getMelFilterbanks(nFilterbanks, fs, maxFrequency
		, minFrequency, K);

	binRes = fs / (2*K);

	s = zeros(1,K);

	for j = 1:cantFrames

	#! FFT (FAST FOURIER TRANSFORM)
		% apply fast fourier transform to each windowed frame
		s = fft(frames(j,:).*h,K);

	# PERIODOGRAMESTIMATE
		% peridogram-based power spectral estimate
		p = (1/frameSamples) * abs(s) .^ 2;

	# MEL FRECUENCY WRAPPING
		% calculate filterbank energies
		melCoefs  = p * filterbanks;

	# CEPSTRUM

		% check positive energies
		melLogCoefs  = log(melCoefs + (melCoefs == 0));

		%dft necesita signal
		% discrete cosine transform
		% keep only first 12 coefficients
		mfcc(j,:) = dct(melLogCoefs,12);

	end

	if (useDeltas)
		deltas = getDeltas(mfcc,N);
		%append  horizontaly
		mfcc = [mfcc,deltas];
		%append verticaly
		%mfcc = [mfcc;deltas];
		if (useDeltas == 2)
			doubleDeltas = getDeltas(deltas,N);
			mfcc=[mfcc,doubleDeltas];
		end
	end
end
