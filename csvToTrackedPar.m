function trackedPar = csvToTrackedPar(basefname, timestep, sizePerPx)
% trackedPar = csvToTrackedPar(basefname, timestep, sizePerPx)
% 
% Convert csv file from Alec's quot tracking code to a format that can be
% imported by the MATLAB version of SpotOn

fname = [basefname, '.csv'];

fname
trajs = csvread(fname,1);


trajIndices = trajs(:,18);
uniqueIndices = unique(trajIndices);


for j = 1:numel(uniqueIndices)
    currRows = trajs(trajIndices == uniqueIndices(j),:);
    
    trackedPar(j).xy = currRows(:,1:2) * sizePerPx;
    trackedPar(j).Frame = currRows(:,16);
    % there's probably a better way to do this by getting the timestamp
    % from the movie metadata:
    trackedPar(j).TimeStamp = currRows(:,16)*timestep; 
    
end

save([basefname '_trackedPar.mat'], 'trackedPar')

end



