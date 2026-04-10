% Purdue Space Program Astrodynamics
% Satellite Constellation Project, 2025-26
% STK Integration for Genetic Algorithm
% Author: Evan Paull
clc; clear; close all

%Constellation Design Parameters
P = 17; % # of planes
S = 11; % # of sats per plane
F = 3;  % Walker phasing parameter
inc = 70;       % inclination [deg]
a = 7078e3;     % semi-major axis. DOES NOT CHANGE [m]

X = [P, S, F, inc]; %parameters to pass to GA

T = P * S; %total satellites

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
satCon = scenario.Children.New('eConstellation', 'satCon');

updateConstellation(X, scenario, satCon)
%satCon = scenario.Children.Item('iAmTheConstellationNow');


times = runSTK(scenario); %Compute Accesses and Extract Coverage Durations
fprintf("COVERAGE TIMES\n")
areas = ["Little Bad: ", "Really Bad: ", "Priority:   "];
for i = 1:length(times)
    fprintf("%s %.3f sec \n", areas(i), times(i))
end

%CALCULATE FITNESS

%RUN GA

%OUTPUT RESULTS

%Leave and close STK
STK.root.CloseScenario();
STK.app.Quit;