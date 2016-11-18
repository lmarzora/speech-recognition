% recordTrainingSample
% record a sample for training
% subject: name of subject 
% sampleName: name of sample
% sec: recording duration in seconds
% fs: sampling frequency

function recordTrainingSample(subject,sampleName,sec,fs)
	dir = strcat('training/',subject);
	recordSpeaker(dir,sampleName,sec,fs);
end
