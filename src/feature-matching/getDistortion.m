% getDistortion
% computes the mapping distortion (squared error distortion)

% codebook: vq codebook
% data: raw samples
% mapping: sample mapping

% returns d: squared error distortion

function d = getDistortion(codebook,data,mapping)
	M = length(data(:,1));
	k = length(data(1,:));

	d = (1/M*k) * sum(norm(data - codebook(mapping,:)).^2);
end
