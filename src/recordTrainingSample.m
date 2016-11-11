function recordTrainingSample(subject,sampleName,sec,fs)
	dir = strcat('training/',subject);
	recordSpeaker(dir,sampleName,sec,fs);
end
