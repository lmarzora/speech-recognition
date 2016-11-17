% addSpeaker
% creates a new codebook or replaces an old one for a speaker

% name: speaker name (A directory named %name% shoould exist and contain
% one or more training audio recordings in wav format

% requires audio package

function addSpeaker(name)
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
		printf('Readig from %s\n',filename);
		[X fs] =  wavread(filename);
		mfcc = [mfcc;extractFeatures(X,fs)];
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
	

end
