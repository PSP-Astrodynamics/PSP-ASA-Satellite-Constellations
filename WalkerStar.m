% Walker Star Constellation 
% Author: Sloan McDonald

sc = satelliteScenario;

T = 72;      % total satellites
P = 6;       % planes
F = 1;       % phasing
alt = 550e3; % altitude
Re = 6378.14e3;
r = Re + alt;   % Orbit Radius
inc = 90;    % degrees

sat = walkerStar(sc, r, inc, T, P, F);

play(sc)
