function addSpeaker(name)
	addpath('feature-extraction','feature-matching');
	dir = sprintf('../data/training/%s/',name);

	if ! exist(dir)
		printf('The speaker training directory was not found\n')
		printf('Please create directory %s in data/training/ and put training samples in it\n',name);
		return;
	end

	files = readdir(dir);
	
	if(length(files) <= 2)
		printf('training samples not found\n');
		return;
	end

	mfcc = [];
	for i= 1 : length(files)
		fileName = files{i};
			if !strcmp(fileName,'.') && !strcmp(fileName,'..')
				path = strcat(dir,fileName);
				mfcc = [mfcc;extractFeatures(path)];
			end
	end

	printf('generating codebook\n');
	fflush(stdout);
		codebook = lbg(mfcc, 1e-5, 16);
	codebookDir = '../data/codebooks/';

	if ! exist(codeBookDir,'dir')
		mkdir(codeBookDir);
	end

	codebookName = strcat(codebookDir,name);
	printf('saving codebook in %s\n',codebookName);
	fflush(stdout);
	dlmwrite(codebookName ,codebook);
	

end
