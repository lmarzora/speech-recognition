function recorder(filename,sec,fs)
	pkg load audio;
	printf('Recording Starting \n Sampling frecuency = %d Hz duration %f \n',fs,sec);
	fflush(stdout)
	[X,fs,ch] = aurecord(sec,fs);
	wavwrite(X,fs,filename);
end
