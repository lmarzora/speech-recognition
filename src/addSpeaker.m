% addSpeaker
% creates a new codebook or replaces an old one for a speaker

% name: speaker name (A directory named %name% shoould exist and contain one or more training audio recordings in wav format
% useDeltas: use dynamic coeficients (default 2);
% N: delta step (default 2)
% frameLength: duration in seconds of frame (default 0.025)
% frameStep: interval in secods between frames (default 0.010)
% nFilterbanks: number of filterbanks to use (default 26)
% minFrequency: lower filterbank frequecy limit in Hz (default 0)

% requires audio package

function addSpeaker(name, useDeltas=2, N=2, frameLength=0.025, frameStep=0.01, nFilterbanks=26, minFrequency=0)
	pkg load audio;
	addpath('feature-extraction','feature-matching');
	
	dir = sprintf('../data/training/%s/',name);

	if (! exist(dir))
		printf('The speaker training directory was not found\n')
		printf('Please create directory %s in data/training/ and put training samples in it\n',name);
		return;
	end	
	
	matcher = '*.wav';
	% gets all .wav files in directory dir
	files = glob(strcat(dir,matcher));

	
	if(length(files) == 0)
		printf('training samples not found\n');
		return;
	end

	mfcc = [];

	% for each training audio generate the corresponding 
	% mel frecuency cepstral coefficients
	for (i = 1 : length(files))
		filename = files{i};
		printf('Reading from %s\n',filename);
		[X fs] =  wavread(filename);
		maxFrequency = fs/2;
		if(minFrequency >= maxFrequency)
			printf('Invalid parameter minFrequency = %d greater than maxFrequency = %d\n',minFrequency, maxFrequency);
			return;
		end
		mfcc = [mfcc;extractFeatures(X,fs, frameLength, frameStep, nFilterbanks, minFrequency, maxFrequency, N, useDeltas)];
	end

	printf('generating codebook\n');
	fflush(stdout);

	% generates a new codebook using LBG vector quantization
	% algorithm
	
	codebook = lbg(mfcc, 1e-5, 16);
	
	codebookDir = '../data/codebooks/';

	% if there is no codebook directory for this speaker a new
	% one is created

	if (! exist(codebookDir,'dir'))
		mkdir(codebookDir);
	end

	codebookName = strcat(codebookDir,name,'.codebook');
	printf('saving codebook in %s\n',codebookName);
	fflush(stdout);
	dlmwrite(codebookName ,codebook);
	
	
	restoredefaultpath();
end
