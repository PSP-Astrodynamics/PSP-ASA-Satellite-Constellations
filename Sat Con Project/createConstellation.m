function createConstellation(X, scenario, satCon)

P = X(1); % # of planes
S = X(2); % # of sats per plane
F = X(3);  % Walker phasing parameter
inc = x(4);       % inclination [deg]

satIndex = 0;

for p = 0:P-1
    for s = 0:S-1

        satName = sprintf('Sat%d', satIndex+1);
        sat = scenario.Children.New('eSatellite', satName);

        sat.SetPropagatorType('ePropagatorTwoBody');

        % Convert to classical elements
        state = sat.Propagator.InitialState.Representation.ConvertTo('eOrbitStateClassical');

        % Size/shape
        state.SizeShapeType = 'eSizeShapeSemimajorAxis';
        state.SizeShape.SemimajorAxis = a;
        state.SizeShape.Eccentricity = 0;

        % Orientation
        state.Orientation.Inclination = inc;
        state.Orientation.RAAN = p * (360/P);

        % True anomaly (THIS is where phasing happens)
        TA = s*(360/S) + p*(F*360/T);
        state.LocationType = 'eLocationTrueAnomaly';
        state.Location.Value = mod(TA,360);

        % Assign and propagate
        sat.Propagator.InitialState.Representation.Assign(state);
        sat.Propagator.Propagate;

        % Add to constellation
        satCon.Objects.AddObject(sat);

        satIndex = satIndex + 1;
    end
end