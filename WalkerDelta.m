% Walker Delta Constellation
% Author: Sloan McDonald
% Syntax is as follows
% sat = walkerDelta(scenario,radius,inclination,totalSatellites,geometryPlanes,phasing)

sc = satelliteScenario;

T = 72;      % total satellites
P = 12;       % planes
F = 1;       % phasing
alt = 550e3; % altitude
Re = 6378.14e3;
r = Re + alt;   % Orbit Radius
inc = 45;    % degrees

sat = walkerDelta(sc, r, inc, T, P, F);
play(sc)

