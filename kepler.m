function [f, tempE] = kepler(M, ecc)

%% Function Header:
%{
Name: Kaushik Vudathu
Date: 01/30/25
Function Name: kepler
Description: Converts Mean anomaly to True anomaly using Newton Raphson

Output Variables: f (True Anomaly) [deg]

Input Variables: M (Mean Anomaly) [deg]
                 ecc (Eccentricity)

%}

%% Initialization

% Degrees to radians conversion for calculations
M = deg2rad(M);

% Check that M is less than 2*pi/360 degrees
if M >= (2*pi)
    M = mod(M, 2*pi);
end

tol = 10^-13;

% Setting temporary ratios and eccentric anomaly values for Newton-Raphson
tempRat = 1;
tempE = M;

%% Calculations

% Newton Raphson method to find true anomaly
while abs(tempRat) > tol
    F = tempE - ecc*sin(tempE) - M;
    FPrime = 1 - ecc*cos(tempE);
    tempRat = F/FPrime;
    tempE = tempE - tempRat;
end

% Convert from eccentric anomaly to true anomaly
f = 2 * atan2(sqrt(1+ecc) * sin(tempE/2), sqrt(1-ecc) * cos(tempE/2));

f = rad2deg(f);