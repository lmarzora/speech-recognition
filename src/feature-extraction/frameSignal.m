%% frameSignal
% frames an audio signal
% frameLength: duration of the frame in seconds
% frameStep: step between intervals
%%	overlap = frameLength - frameStep
% signal: 
% sf: sampling fecuency

function [frames frameSamples cantFrames] = frameSignal(frameLength, frameStep, signal, sf)

	% number of samples in a frame
	% = frame length (s) * sampling frecuency (Hz)
	
	frameSamples = ceil(frameLength * sf);

	% number of samples in a step
	% = sample length (s) * sampling frecuency (Hz)

	step = ceil(frameStep * sf);

	totalSamples = length(signal);

	% total number of frames
	cantFrames =  ceil(totalSamples/frameSamples);

	% pad with zeros
	frames = zeros(cantFrames,frameSamples);

	for i = 1:cantFrames
		start = ((i - 1) * step) + 1;
		frames(i,:) = signal(start : start + frameSamples - 1);
	end

end

