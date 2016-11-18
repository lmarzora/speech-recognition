% recordTestSample
% record a sample for testing
% sampleName: name of sample
% sec: recording duration in seconds
% fs: sampling frequency

function recordTestSample(sampleName,sec,fs)
	recordSpeaker('test',sampleName,sec,fs);
end
