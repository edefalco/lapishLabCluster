% stage3Job
%
%   stage3Job runs the third stage of the kilosort spike sorting on Big 
%   Red 2 for multiple parallel data sets. This stage handles imposing the 
%   rulings from stage 2 on the selected neurons and transporting the 
%   organized data back to IU Box.

%% Settings

% List any general settings for the spike sorting here. These won't change
% between jobs.

% Set the main directory on the data capacitor to store data (something
% like...)
mainDC = '/N/dc2/scratch/nmtimme/batch1';


%% Load the job information

% Find the job number
jobNum = str2num(getenv('PBS_ARRAYID'));
% jobNum = 1;

% Load the job info
load([mainDC,filesep,'spikeSortingStage3Info.mat'])

% Get the directories and parameters for this specific job
boxDataSetDir = boxDataSetDirs{jobNum};
params = dataSetParams(jobNum,:);
dcDataSetDir = dcDataSetDirs{jobNum};
dataSetID = dataSetIDs{jobNum};

%% Run the core function

% Add the clustering software directories to the path
cd ..
addpath(genpath(pwd))

% Put the necessary information in an input structure for the core function
info = struct;
info.boxDataSetDir = boxDataSetDir;
info.dataSetParams = params;
info.dcDataSetDir = dcDataSetDir;
info.dataSetID = dataSetID;
info.IUstring = IUstring;
info.mainDC = mainDC;
info.username = username;

% Run the core function
stage3Core(info)


