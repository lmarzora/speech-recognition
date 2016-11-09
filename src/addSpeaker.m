function addSpeaker(name)
	addpath('feature-extraction','feature-matching');
	dir = sprintf('../data/training/%s/',name);
	files = readdir(dir);
	
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
	codebookName = strcat(codebookDir,name);
	printf('saving codebook in %s\n',s);
	fflush(stdout);
	dlmwrite(codebookName ,codebook);
	

end
