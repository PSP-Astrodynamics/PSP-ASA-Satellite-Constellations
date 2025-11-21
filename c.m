classdef c
    properties(Constant = true)
        G = 6.6743e-20; % [km^3/kg/s^2]
        speedLight = 299792.458; % [km/s]
        J2 = 0.001082635;

        earth = struct(...
            'mu', 398600.4418, ... % [km^3/s^2]
            'radius', 6378.137, ... % [km]
            'mass', 5.97219e24, ... % [kg]
            'angVel', rad2deg(7.2921151467e-5), ... % [deg/s]
            'angVelRad', 7.2921151467e-5, ... % [rad/s]
            'Y2D', 365.2421987... % [days]
            );

        time = struct( ...
            'siderealDay', 86164.1, ... % [s]
            'solarDay', 86400, ... % [s]
            'julianDay', 86400, ... % [s]
            'julianYear', 365.25 * 86400, ... % [s]
            'j2000Epoch', 2451545.0 ... % J2000 epoch in Julian date
            );
    end
end