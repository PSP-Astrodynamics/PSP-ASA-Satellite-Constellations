% Purdue Space Program Astrodynamics
% Satellite Constellation Project, 2025-26
% STK Integration for Genetic Algorithm
% Author: Evan Paull
clc; clear; close all

%X = [n, inclination, RAAN_spacing];

%Create a new STK instance (all properties stored in 'STK' struct)
STK.app = actxserver('STK13.application');
STK.app.Visible = 1;
STK.root = STK.app.Personality2;

%Define STK scenario, and load scenario
STK.root.CloseScenario();
STK.scenarioPath = 'C:\Users\evanc\Documents\STK_ODTK 13\SatCon\SatCon.sc';
STK.root.Load(STK.scenarioPath);
scenario = STK.root.CurrentScenario;

%Access Relevant Objects
satCon = STK.root.CurrentScenario.Children.Item('iAmTheConstellationNow');

times = runSTK(STK); %Compute Accesses and Extract Coverage Durations
fprintf("COVERAGE TIMES\n")
areas = ["Little Bad: ", "Really Bad: ", "Priority:   "];
for i = 1:length(times)
    fprintf("%s %.3f sec \n", areas(i), times(i))
end

%CALCULATE FITNESS

%RUN GA
%updateConstellation(satCon, X);

%OUTPUT RESULTS

%Leave and close STK
STK.root.CloseScenario();
STK.app.Quit;