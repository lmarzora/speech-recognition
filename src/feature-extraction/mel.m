% mel(f)
% transforms Hz to Mel 

function mel = mel(f)
	mel = 1125*log(1 + f/700);
end

