function f = calculateFitness(x, scenario, root)

    % Enforce integer design variables
    P   = max(1, round(x(1)));
    S   = max(1, round(x(2)));
    F   = round(x(3));
    inc = x(4);
    if F>=P
        F=P-1;
    end
    x = [P, S, F, inc];

    %try
        % 1. Update constellation & Reset Time
        updateConstellation(x, scenario, root);
        
        % Reset time BEFORE computing coverage
        root.Rewind;
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
        wBad       = 0.1;
        wVeryBad   = 0.3;

        % 4. Fitness (maximize coverage → minimize negative)
        score = wPriority*(priority/86400)^2 - ...
                wBad*(reallyBad/86400)^2 - ...
                wVeryBad*(littleBad/86400)^2;
        
        f = -1*score;
        
    
end