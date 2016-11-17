% melInv(m)
% transforms Mel to Hz

function inv = melInv(m)
	inv = 700*(e.^(m/1125)-1);
end

