% Walker Delta Constellation
% Author: Nathan Champley + Sloan McDonald
% Syntax is as follows
% sat = walkerDelta(scenario,radius,inclination,totalSatellites,geometryPlanes,phasing)

sc = satelliteScenario;

T = 17*11;      % total satellites
P = 17;       % planes  P*n=T
F = 3;       % phasing  0<F<P
alt = 550e3; % altitude
Re = 6378.14e3; % radius of earth
r = Re + alt;   % Orbit Radius
inc = 45;    % degrees


sat = walkerDelta(sc, r, inc, T, P, F); % walker delta satelites
sat2 = satellite(sc, r, 0, 90, 0, 0, 0); % polar orbit
gs = groundStation(sc,1,103.9); % ground station at 1N 103.9E
ac = access(sat,gs); % green lines of visibility for each satelite in view of groundstation
v = satelliteScenarioViewer(sc,'ShowDetails',false); % hide labels
play(sc)
