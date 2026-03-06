% Purdue Space Program Astrodynamics
% Satellite Constellation Project, 2025-26
% STK Integration for Genetic Algorithm
% Author: Evan Paull
clc; clear; close all

%Create a new STK instance (all properties stored in 'STK' struct)
STK.app = actxserver('STK13.application');
STK.root = STK.app.Personality2;

%Define STK scenario, and load scenario
STK.scenarioPath = 'C:\Users\evanc\Documents\STK_ODTK 13\SatCon\SatCon.sc';
scenario = STK.root.LoadScenario(STK.scenarioPath);


%Leave and close STK
%STK.root.CloseScenario;
%STK.app.Quit;
