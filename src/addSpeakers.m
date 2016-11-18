% addSpeakers
% creates new codebooks or replaces  old ones for speakers 

% speakers: cell array of speaker names (A directory named speakers{i} shoould exist and contain one or more training audio recordings in wav format
% useDeltas: use dynamic coeficients (default 1);
% N: delta step (default 2)
% frameLength: duration in seconds of frame (default 0.025)
% frameStep: interval in secods between frames (default 0.010)
% nFilterbanks: number of filterbanks to use (default 26)
% minFrequency: lower filterbank frequecy limit in Hz (default 0)

% requires audio package
function addSpeakers(speakers, useDeltas = 2, N = 2, frameLength = 0.025, frameStep = 0.010, nFilterbanks = 26, minFrequency = 0)
	for i = 1 : length(speakers)
		addSpeaker(speakers{i}, useDeltas, N, frameLength, frameStep, nFilterbanks, minFrequency);
	end

end
