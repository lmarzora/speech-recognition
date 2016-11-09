function mfcc = extractFeatures(filename)
	pkg load signal
	printf('Reading from %s\n', filename);
	fflush(stdout);
	[X fs nbits] = wavread(filename);

	#FRAME SIGNAL
	[frames frameSamples cantFrames] =  frameSignal(0.025,0.010,X,fs);

	N = frameSamples;
	# WINDOW SAMPLE check mono
	h = hanning(N)';

	K = 512;
	# COMPUTE MEL FILTERBANK
	filterbanks = getMelFilterbanks(26,8000,300,K,fs);

	binRes = fs / (2*512);

	s = zeros(1,K);

	for j = 1:cantFrames

	#! FFT (FAST FOURIER TRANSFORM)
		s = fft(frames(j,:).*h,K);

	# PERIODOGRAMESTIMATE
		p = (1/frameSamples) * abs(s) .^ 2;

	# MEL FRECUENCY WRAPPING
		melCoefs  = p * filterbanks';

	# CEPSTRUM
		melLogCoefs  = log(melCoefs);
		%dft necesita signal
		mfcc(j,:) = dct(melLogCoefs);

	end
end

function H = getMelFilterbanks(cant,high,low,binSize,fs)
	mels = mel([high,low]);
	step = (mels(1) - mels(2))/(cant + 2);
	m = [mels(2)  : step : mels(1)];
	h = melInv(m);
	f = floor((binSize + 1) * h / fs);
	H =  zeros(26,binSize);
	for m = 2 : cant + 1
		for k = 1 : binSize
			if (f(m-1) <= k && k <= f(m))
				H(m-1,k) = (1.0)*(k - f(m-1))/(f(m) - f(m-1));
			else if (f(m) <= k && k <= f(m+1))
				H(m-1,k) = (1.0)*(f(m+1) - k)/(f(m+1) - f(m));
			     end
			end

		end
	end
end

function mel = mel(f)
	mel = 1125*log(1 + f/700);
end

function inv = melInv(m)
	inv = 700*(e.^(m/1125)-1);
end

function [frames frameSamples cantFrames] = frameSignal(frameLength, frameStep, signal, sf)

	# nro de muestras por frame  = longitud del frame (ms) * frecuencia de muestreo (Hz)
	frameSamples = ceil(frameLength * sf);

	# nro de muestras en un step
	step = ceil(frameStep * sf);

	totalSamples = length(signal);

	#tomo el techo relleno con 0
	cantFrames =  ceil((1.0)*totalSamples/frameSamples);

	frames = zeros(cantFrames,frameSamples);

	for i = 1:cantFrames
		start = ((i-1)*step)+1;
		frames(i,:) = signal(start:start + frameSamples  - 1);
	end

end
