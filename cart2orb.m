function [a,ecc,inc,raan,argp,f] = cart2orb(x,y,z,vx,vy,vz)

%% Function Header:
%{
Name: Kaushik Vudathu
Date: 01/30/25
Function Name: cart2orb
Description: Converts cartesian coordinates to Keplerian orbital elements

Output Variables: a (Semimajor axis) [km]
                 ecc (Eccentricity) 
                 inc (Inclination) [deg]
                 raan (Right Ascension of the Ascending Node) [deg]
                 argp (Argument of Perigee) [deg]
                 f (True Anomaly) [deg]

Input Variables: x [km]
                  y [km]
                  z [km]
                  vx [km/s]
                  vy [km/s]
                  vz [km/s]
%}

%% Initialization

% Earth Gravitational Constant [km^3/s^2]
muEarth = 398600.4418;

posVec = [x, y, z];
velVec = [vx, vy, vz];

%% Calculations

% Orbital Momentum Vector [km^2/s]
h = cross(posVec, velVec);

% Inclination 
inc = acosd(h(3)./norm(h));

% Eccentricity
eccVec = (cross(velVec, h)./muEarth) - posVec./(norm(posVec));

ecc = norm(eccVec);

% Node Vector
nVec = cross([0, 0, 1], h);

n = norm(nVec);

% RAAN
if nVec(2) >= 0
    raan = acosd(nVec(1)./n);
else
    raan = 360 - acosd(nVec(1)./n);
end

% Argument of Periapsis
if eccVec(3) >= 0
    argp = acosd(dot(nVec, eccVec)./(n*ecc));
else
    argp = 360 - acosd(dot(nVec, eccVec)./(n*ecc));
end

% True Anomaly
if (dot(posVec, velVec)) >= 0
    f = acosd(dot(eccVec, posVec)./(ecc*norm(posVec)));
else
    f = 360 - acosd(dot(eccVec, posVec)./(ecc*norm(posVec)));
end

% Specific Orbital Energy
eps = (norm(velVec)^2)/2 - muEarth/norm(posVec);

% Semi-major axis
a = -muEarth/(2*eps);
