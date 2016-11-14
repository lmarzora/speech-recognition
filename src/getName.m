function name = getName(filename)
	s = strsplit(filename,'/');
	s = s{end};
	s = strsplit(s,'.');
	name = s{1};
end
