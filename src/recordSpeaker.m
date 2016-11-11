function recordSpeaker(subject,sampleName,sec,fs)
	addpath('recorder');
	dir = sprintf('../data/%s/',subject);
	if ! exist(dir,'dir')
		mkdir(dir);
	end 
	filePath = strcat(dir,sampleName)
	recorder(filePath,sec,fs);

end
