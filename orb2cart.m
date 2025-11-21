function [x,y,z,vx,vy,vz] = orb2cart(a,ecc,inc,raan,argp,f)

%% Function Header:
%{
Name: Kaushik Vudathu
Date: 01/30/25
Function Name: orb2cart
Description: Converts Keplerian orbital elements to cartesian coordinates

Output Variables: x [km]
                  y [km]
                  z [km]
                  vx [km/s]
                  vy [km/s]
                  vz [km/s]

Input Variables: a (Semimajor axis) [km]
                 ecc (Eccentricity) 
                 inc (Inclination) [deg]
                 raan (Right Ascension of the Ascending Node) [deg]
                 argp (Argument of Perigee) [deg]
                 f (True Anomaly) [deg]

%}

%% Initialization

% Earth Gravitational Constant [km^3/s^2]
muEarth = 398600.4418;

%% Calculation

% Calculate semi latus rectum
p = a * (1 - ecc^2);
% Calculate radius
r = a * (1 - ecc^2)/(1 + ecc * cosd(f));

% Perifocal frame cartesian coordinates
x_p = r * cosd(f);
y_p = r * sind(f);
z_p = 0;

vx_p = -1 * sqrt(muEarth/p) * sind(f);
vy_p = sqrt(muEarth/p) * (ecc + cosd(f));
vz_p = 0;

% Transform from perifocal to ECI
    % 
    % R3_W = [cos(raan) -sin(raan) 0; sin(raan) cos(raan) 0; 0 0 1];
    % R1_i = [1 0 0; 0 cos(inc) -sin(inc); 0 sin(inc) cos(inc)];
    % R3_w = [cos(argp) -sin(argp) 0; sin(argp) cos(argp) 0; 0 0 1];
    % R = R3_W * R1_i * R3_w;

R = [(cosd(argp) * cosd(raan) - sind(argp) * sind(raan) * cosd(inc)),...
          (-sind(argp) * cosd(raan) - cosd(argp) * sind(raan) * cosd(inc)),...
          (sind(raan) * sind(inc));...
          (cosd(argp) * sind(raan) + sind(argp) * cosd(raan) * cosd(inc)),...
          (-sind(argp) * sind(raan) + cosd(argp) * cosd(raan) * cosd(inc)),...
          (-cosd(raan) * sind(inc));...
          (sind(argp) * sind(inc)),...
          (cosd(argp) * sind(inc)),...
          (cosd(inc))];


% Definining position and velocity vectors by multiplying dcm
posVec = R * [x_p, y_p, z_p]';
x = posVec(1);
y = posVec(2);
z = posVec(3);

velVec = R * [vx_p, vy_p, vz_p]';
vx = velVec(1);
vy = velVec(2);
vz = velVec(3);