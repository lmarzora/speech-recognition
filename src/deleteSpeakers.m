% deleteSpeakers
% deletes the codebooks of speakers 

% names: cell array of speaker names

function deleteSpeakers(names)
	for i = 1 : length(names)
		deleteSpeakers(names{i});
	end
end
