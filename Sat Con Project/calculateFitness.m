function f = calculateFitness(x, scenario, satCon)

    % Enforce integer design variables
    P   = max(1, round(x(1)));
    S   = max(1, round(x(2)));
    F   = round(x(3));
    inc = x(4);

    x = [P, S, F, inc];

    %try
        % 1. Update constellation & Reset Time
        updateConstellation(x, scenario, satCon);
        % Reset time BEFORE computing coverage
        root.ExecuteCommand('Animate * Reset');

        % 2. Run STK coverage analysis
        % Expected output order:
        % [LittleBad, ReallyBad, Priority]
        times = runSTK(scenario);

        littleBad = times(1);
        reallyBad = times(2);
        priority  = times(3);

        % 3. WEIGHTS (edit as needed)
        wPriority  = 0.6;
        wBad       = 0.3;
        wVeryBad   = 0.1;

        % 4. Fitness (maximize coverage → minimize negative)
        score = (wPriority  * priority^2) + ...
                (wBad       * reallyBad) + ...
                (wVeryBad   * littleBad);

        f = -score;

    %catch
        % Penalize invalid STK states
        %f = 1e6;
    %end
end