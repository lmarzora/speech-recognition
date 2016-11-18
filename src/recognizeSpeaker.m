% recognizeSpeaker
% recogizes the speaker of a sample by calculating the mfcc and finding the codebook in data/codebooks/ that minimizes distortion
% fileName: name of a .wav file in data/test/ 

% useDeltas: use dynamic coeficients (default 2);
% N: delta step (default 2)
% frameLength: duration in seconds of frame (default 0.025)
% frameStep: interval in secods between frames (default 0.010)
% nFilterbanks: number of filterbanks to use (default 26)
% minFrequency: lower filterbank frequecy limit in Hz (default 0)

% requires audio package


function name = recognizeSpeaker(fileName, useDeltas = 2, N = 2, frameLength=0.025, frameStep=0.01, nFilterbanks=26, minFrequency=0)
	addpath('feature-extraction','feature-matching');
	pkg load audio;

	[X, fs] = wavread(strcat('../data/test/',fileName));
	maxFrequency = fs/2;
	if(minFrequency >= maxFrequency)
		printf('Invalid parameter minFrequency = %d greater than maxFrequency = %d\n',minFrequency, maxFrequency);
		return;
	end

	% calculate sample coefficients
	mfcc = extractFeatures(X, fs, frameLength, frameStep, nFilterbanks, minFrequency, maxFrequency, N, useDeltas);
	
	dir = '../data/codebooks/';

	matcher = '*.codebook';

	% get all codebook filenames	
	files = glob(strcat(dir,matcher));
	
	% for each codebook calculate distortion
	for i = 1 : length(files);
		file = files{i};
		speakerName{i} = getName(file);
		printf('matching against: %s\n',speakerName{i});
		fflush(stdout);
		codebook = dlmread(file);

		Q = getMapping(codebook,mfcc);
		d(i) = getDistortion(codebook,mfcc,Q);
		printf('distortion: %d\n',d(i));
		fflush(stdout);
	end
		
	% find min distortion
	minDistortion = min(d);
	i = find(d==minDistortion);
	name = speakerName{i};
	printf('Speaker: %s with distortion %f\n',name,minDistortion);
	
	restoredefaultpath();
end
