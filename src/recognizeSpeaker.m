function name = recognizeSpeaker(fileName)
	addpath('feature-extraction','feature-matching');
	dir = strcat('../data/test/',fileName);
	mfcc = extractFeatures(dir);
	
	dir = '../data/codebooks/';

	matcher = '*.codebook';
	
	files = glob(strcat(dir,matcher));
	
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
		
	minDistortion = min(d);
	i =find(d==minDistortion);
	name = speakerName{i};
	printf('Speaker: %s with distortion %f\n',name,minDistortion);

end
