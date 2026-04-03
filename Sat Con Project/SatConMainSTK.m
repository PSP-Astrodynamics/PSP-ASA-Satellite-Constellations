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

%Access Coverage Areas
littleBad = STK.root.CurrentScenario.Children.Item('LittleBad');
dpLB = littleBad.DataProviders.Item('Access Duration');

reallyBad = STK.root.CurrentScenario.Children.Item('ReallyBad');
dpRB = reallyBad.DataProviders.Item('Access Duration');

priority = STK.root.CurrentScenario.Children.Item('Priority');
dpP = priority.DataProviders.Item('Access Duration');

%
dpElementLB = dpLB.Exec(startTime, stopTime, timeStep);
dpElementRB = dpRB.Exec(startTime, stopTime, timeStep);
dpElementP  = dpP.Exec(startTime, stopTime, timeStep);

% Extract time and access duration
times = cell2mat(dpElementLB.DataSets.GetDataSetByName('Time').GetValues);
coverageTime = cell2mat(dpElementLB.DataSets.GetDataSetByName('Access Duration').GetValues);

%Leave and close STK
%STK.root.CloseScenario();
%STK.app.Quit;