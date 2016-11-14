function addSpeaker(name)
	addpath('feature-extraction','feature-matching');
	dir = sprintf('../data/training/%s/',name);

	if ! exist(dir)
		printf('The speaker training directory was not found\n')
		printf('Please create directory %s in data/training/ and put training samples in it\n',name);
		return;
	end

	matcher = '*.wav';
	files = glob(strcat(dir,matcher));

	
	if(length(files) == 0)
		printf('training samples not found\n');
		return;
	end

	mfcc = [];
	for i= 1 : length(files)
		fileName = files{i};
		mfcc = [mfcc;extractFeatures(fileName)];
	end

	printf('generating codebook\n');
	fflush(stdout);
	codebook = lbg(mfcc, 1e-5, 16);
	codebookDir = '../data/codebooks/';

	if ! exist(codebookDir,'dir')
		mkdir(codebookDir);
	end

	codebookName = strcat(codebookDir,name,'.codebook');
	printf('saving codebook in %s\n',codebookName);
	fflush(stdout);
	dlmwrite(codebookName ,codebook);
	

end
