function satCon = updateConstellation(X, scenario, satCon)
    % Unload old constellation entirely
    try
        scenario.Children.Item('satCon').Unload();
    catch
        % Didn't exist yet, no problem
    end

    % Recreate fresh constellation object
    satCon = scenario.Children.New('eConstellation', 'satCon');
    pause(0.1);

    % Unpack parameters
    P   = round(X(1)); % # of planes
    S   = round(X(2)); % # of sats per plane
    F   = round(X(3)); % phasing parameter
    inc = X(4);        % inclination [deg]

    a   = 7078e3;      % semi-major axis [m] — fixed
    ecc = 0;           % circular orbit
    aop = 0;           % argument of perigee [deg]
    T   = P * S;       % total satellites

    %sc = satelliteScenario;
    %sat = walkerDelta(sc, a, inc, T, P, F);

    %elements = zeros(7, length(sat));

    %for j = 1:length(sat)
     %  elem  = orbitalElements(sat(j));
      % elements(1, j) = elem.SemiMajorAxis;
       %elements(2, j) = elem.Eccentricity;
       %elements(3, j) = elem.Inclination;
       %elements(4, j) = elem.RightAscensionOfAscendingNode;
       %elements(5, j) = elem.ArgumentOfPeriapsis;
       %elements(6, j) = elem.TrueAnomaly;
       %elements(7, j) = elem.Period;
    %end

    RAAN_spacing = 360 / P;
    phase_offset = F * (360 / T);

    for p = 0:P-1
        RAAN = p * RAAN_spacing;

        for s = 0:S-1

            TA = mod(s*(360/S) + p*phase_offset, 360);

            satName = sprintf('Sat_%d_%d', p+1, s+1);

            sat = scenario.Children.New('eSatellite', satName);
            sat.SetPropagatorType('ePropagatorTwoBody');

            prop = sat.Propagator;
            prop.Propagate();
            state = prop.InitialState.Representation.ConvertTo('eOrbitStateClassical');

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

