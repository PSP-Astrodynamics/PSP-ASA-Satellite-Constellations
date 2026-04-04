% Purdue Space Program Astrodynamics
% Satellite Constellation Project, 2025-26
% STK Integration for Genetic Algorithm
% Author: Evan Paull
clc; clear; close all

%Create a new STK instance (all properties stored in 'STK' struct)
STK.app = actxserver('STK13.application');
STK.app.Visible = 1;
STK.root = STK.app.Personality2;

%Define STK scenario, and load scenario
STK.root.CloseScenario();
STK.scenarioPath = 'C:\Users\evanc\Documents\STK_ODTK 13\SatCon\SatCon.sc';
STK.root.Load(STK.scenarioPath);
scenario = STK.root.CurrentScenario;

% Specify the time interval
startTime = STK.root.CurrentScenario.StartTime;
stopTime  = STK.root.CurrentScenario.StopTime;
%timeStep = STK.root.CurrentScenario.Interval
timeStep = 60;

%Access Relevant Objects
satCon = STK.root.CurrentScenario.Children.Item('iAmTheConstellationNow');
littleBad = STK.root.CurrentScenario.Children.Item('LittleBad');
reallyBad = STK.root.CurrentScenario.Children.Item('ReallyBad');
priority = STK.root.CurrentScenario.Children.Item('Priority');

%Compute Acesses
littleBad.ComputeAccesses();
reallyBad.ComputeAccesses();
priority.ComputeAccesses();

littleBad.ExportAccessesAsText('C:\Users\evanc\Documents\LittleBadAccess.txt');
dataLB = readtable('C:\Users\evanc\Documents\LittleBadAccess.txt');
disp(dataLB);

%Extract Access Intervals and Durations
dpLB = littleBad.DataProviders.Item('Access Duration');
%dpRB = reallyBad.DataProviders.Item('Access Duration');
%dpP  = priority.DataProviders.Item('Access Duration');

%dpElementLB = dpLB.ExecElements();
%dpElementRB = dpRB.Exec();
%dpElementP  = dpP.Exec();

% See exactly what fields are returned
for j = 0 : dpElementLB.DataSets.Count - 1
    disp(dpElementLB.DataSets.Item(j).Name);
end

% Check children of the coverage definition
for i = 0 : littleBad.Children.Count - 1
    child = littleBad.Children.Item(i);
    fprintf('%s (%s)\n', child.InstanceName, child.ClassName);
end

%durationLB = cell2mat(dpElmementLB.DataSets.GetDataSetByName('Duration').GetValues);
%durationRB = cell2mat(dpElementRB.DataSets.GetDataSetByName('Duration').GetValues);
%durationP  = cell2mat(dpElementP.DataSets.GetDataSetByName('Duration').GetValues);

%Leave and close STK
STK.root.CloseScenario();
STK.app.Quit;