% addAllSpeakers
% creates new codebooks or replaces  old ones for speakers 

% useDeltas: use dynamic coeficients (default 1);
% N: delta step (default 2)
% frameLength: duration in seconds of frame (default 0.025)
% frameStep: interval in secods between frames (default 0.010)
% nFilterbanks: number of filterbanks to use (default 26)
% minFrequency: lower filterbank frequecy limit in Hz (default 0)

function addAllSpeakers()
	trainingDir = '../data/training';
	currentDir = pwd;
	cd(trainingDir);
	names = glob('*')
	cd(currentDir);
	pwd
	addSpeakers(names, useDeltas = 2, N = 2, frameLength = 0.025, frameStep = 0.010, nFilterbanks = 26, minFrequency = 0);
end
