%% bool = isVoiced(Cx) 
% Determines if a sound is voiced based on its cross correlation values. 
% 
% INPUT 
% - Cx vector of cross correlation samples for shifts varying 
% from 0 to numel(Cx)-1. 
% OUTPUT 
% - bool 1 (true) if the sound is voiced, 0 (false) otherwise. 

function bool = isVoiced(Cx, fs) 

    xcorr = UnbiasedCrossCorr(Cx, length(Cx)-1); 
    [peaks, locations] = findpeaks(xcorr);  
    f = mean(diff(locations)) / fs ;

bool = f > 0.002; 

end 