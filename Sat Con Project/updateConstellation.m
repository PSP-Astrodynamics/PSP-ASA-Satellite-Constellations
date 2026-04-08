function updateConstellation(satCon, x)

    sats = satCon.Objects;

    N   = round(x(1));
    a   = x(2);
    inc = x(3);
    dRAAN = x(4);

    for i = 0:sats.Count-1

        sat = sats.Item(i);

        state = sat.Propagator.InitialState.Representation.ConvertTo('eOrbitStateClassical');

        state.SizeShape.SemimajorAxis = a;
        state.Orientation.Inclination = inc;
        state.Orientation.RAAN = i*dRAAN;

        sat.Propagator.InitialState.Representation.Assign(state);
        sat.Propagator.Propagate;
    end
end