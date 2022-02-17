addpath C:\Users\User\Dropbox\MATLAB_code\bfmatlab

%%

% base file name of movie and csv file
basefname = 'G:/SPT_analysis/20220121_Cdk9_CycT1_DRB_MFM/Cdk9_000'; 

% starting and ending frames to visualize
startframe=1;
endframe=100;

% output movie name
outfname = 'test.mp4';

% microns per pixel
micronsPerPx = 0.16;

% color axis to use for display
cax = [0,1e4];

% call the function
visualizeTrajectories3(basefname,startframe,endframe, ...
    outfname,cax)