function framerate = getFramerateND2(basefname)
% deltaT = getDeltaT_allND2(basefname)
%
% get frame rate of all the ND2 files starting with basefname
% 
% Requires BioFormats plugin for MATLAB
% https://www.openmicroscopy.org/bio-formats/downloads/
% 
% output:
% framerate - 2-column cell array with file name and frame rate
% 
% input:
% basefname - file name prefix
% 
% Thomas Graham, Tjian-Darzacq lab, 20200823

directoryname = fileparts(basefname);
fnames = ls([basefname '*.nd2']);

framerate = {};

for j=1:size(fnames,1)
    currfname = strip(fnames(j,:));
    currfname = [directoryname filesep currfname];
    r = bfGetReader(currfname);
    m = r.getMetadataStore;
    dt = double(m.getPlaneDeltaT(0,1).value) - double(m.getPlaneDeltaT(0,0).value);
    fprintf('%s\t%f\n',currfname,dt)
    framerate{j}{1} = currfname;
    framerate{j}{2} = dt;
end

end
