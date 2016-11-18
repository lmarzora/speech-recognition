% record speaker
% records a sample
% directory: directory in data where the sample will be saved
% sampleName: name of sample
% sec: recording duration in seconds
% fs: sampling frequency

% should be invoked with aoss octave

function recordSpeaker(directory,sampleName,sec,fs)
	addpath('recorder');
	dir = sprintf('../data/%s/',directory);
	if ! exist(dir,'dir')
		mkdir(dir);
	end 
	filePath = strcat(dir,sampleName)
	recorder(filePath,sec,fs);
	restoredefaultpath();
end
