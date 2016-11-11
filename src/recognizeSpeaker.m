function name = recognizeSpeaker(fileName)
	addpath('feature-extraction','feature-matching');
	dir = strcat('../data/test/',fileName);
	mfcc = extractFeatures(dir);
	
	dir = '../data/codebooks/';
	allFiles = readdir(dir);
	k=0;
	for i = 1 : length(allFiles)
		if !strcmp(allFiles{i},'.') && !strcmp(allFiles{i},'..')
			k++;
			files{k} = allFiles{i};
		end
	end
	
	for i = 1 : k
		file = files{i};
		printf('matching against: %s\n',file);
		fflush(stdout);
		path = strcat(dir,file);
		codebook = dlmread(path);

		Q = getMapping(codebook,mfcc);
		d(i) = getDistortion(codebook,mfcc,Q);
		printf('distortion: %d\n',d(i));
		fflush(stdout);
	end
		
	d
	minDistortion = min(d)
	i =find(d==minDistortion)
	name = files{i};

end
