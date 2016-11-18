% deleteSpeaker
% deletes speakerName codebbook

% speakerName: name of the speaker to be deleted
function deleteSpeaker(speakerName)
	unlink(sprintf('../data/codebooks/%s.codebook',speakerName));
end
