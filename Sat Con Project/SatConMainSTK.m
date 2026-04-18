% Purdue Space Program Astrodynamics
% Satellite Constellation Project, 2025-26
% STK Integration for Genetic Algorithm
% Author: Evan Paull
clc; clear; close all

%Constellation Design Parameters
P = 12; % # of planes
S = 3;  % # of sats per plane
F = 5;  % Walker phasing parameter
inc = 40;       % inclination [deg]
a = 707.8e3;     % semi-major axis. DOES NOT CHANGE [m]

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
root = STK.root;
scenario = STK.root.CurrentScenario;

satCon = scenario.Children.Item('iAmTheConstellationNow');
Tmax = 10;

for i = 1:Tmax
    satName = sprintf('Sat_%d', i);
    try
        scenario.Children.Item(satName); % already exists
    catch
        sat = scenario.Children.New('eSatellite', satName);
        sat.SetPropagatorType('ePropagatorTwoBody');
    end
end

% ================= GA SETUP =================

nvars = 4;   % [P, S, F, inc]

lb = [1, 1, 0, 0];      % lower bounds
ub = [15, 10, 10, 98];  % upper bounds

% Ensure integers are handled inside fitnessFcn via round()

options = optimoptions('ga', ...
    'PopulationSize', 15, ...
    'MaxGenerations', 2, ...
    'Display', 'iter', ...
    'UseParallel', false);   % IMPORTANT for STK COM

% ================= RUN GA =================

fitnessHandle = @(x) calculateFitness(x, scenario, satCon, root);

[x_opt, fval] = ga(fitnessHandle, nvars, [], [], [], [], lb, ub, [], options);

% ================= RESULTS =================

fprintf('\nOptimal solution:\n');
fprintf('P = %d\n', round(x_opt(1)));
fprintf('S = %d\n', round(x_opt(2)));
fprintf('F = %d\n', round(x_opt(3)));
fprintf('inc = %.2f\n', x_opt(4));
fprintf('Fitness = %.4f\n', fval);

%Leave and close STK
STK.root.CloseScenario();
STK.app.Quit;