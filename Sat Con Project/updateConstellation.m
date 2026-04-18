function satCon = updateConstellation(X, scenario, satCon)

    % Remove old constellation
    try
        scenario.Children.Item('satCon').Unload();
    end

    satCon = scenario.Children.New('eConstellation', 'satCon');

    pause(0.1);

    % Unpack parameters
    P = max(1, round(X(1))); % # of planes
    S = max(1, round(X(2))); % # of sats per plane
    F   = round(X(3)); % phasing parameter
    inc = X(4);        % inclination [deg]

    a   = 7078e3;      % semi-major axis [m] — fixed
    ecc = 0;           % circular orbit
    aop = 0;           % argument of perigee [deg]
    T   = P * S;       % total satellites

    RAAN_spacing = 360 / P;
    phase_offset = F * (360 / T);

    for p = 0:P-1
        RAAN = p * RAAN_spacing;

        for s = 0:S-1

            TA = mod(s*(360/S) + p*phase_offset, 360);

            satName = sprintf('Sat_%d_%d', p+1, s+1);

            try
                sat = scenario.Children.Item(satName);
            catch
                sat = scenario.Children.New('eSatellite', satName);
            end

            sat.SetPropagatorType('ePropagatorTwoBody');

            prop = sat.Propagator;
            state = prop.InitialState.Representation.ConvertTo('eOrbitStateClassical');
            prop.Propagate();

            state.SizeShapeType = 'eSizeShapeSemimajorAxis';
            state.SizeShape.SemimajorAxis = a;
            state.SizeShape.Eccentricity = ecc;

            state.Orientation.Inclination = inc;
            %state.OrientationType = 'eOrientationClassical';
            state.Orientation.AscNode.Value = RAAN;
            state.Orientation.ArgOfPerigee = aop;

            state.LocationType = 'eLocationTrueAnomaly';
            state.Location.Value = TA;

            prop.InitialState.Representation.Assign(state);
            prop.Propagate();

            satCon.Objects.AddObject(sat);
        end
    end

    % Link to coverage
    areaNames = {'LittleBad', 'ReallyBad', 'Priority'};

    for i = 1:length(areaNames)

        covDef = scenario.Children.Item(areaNames{i});
        covDef.AssetList.RemoveAll();

        % Add each satellite individually
        for p = 0:P-1
            for s = 0:S-1
                satName = sprintf('Sat_%d_%d', p+1, s+1);
                satPath = sprintf('Satellite/%s', satName);

                covDef.AssetList.Add(satPath);
            end
        end
    end
end