function [coverageTimes] = runSTK(scenario)
    % This function runs the STK propagation by computing accesses and 
    % returns the coverage time for the three coverage definitions.

    %Access Coverage Areas
    littleBad = scenario.Children.Item('LittleBad');
    reallyBad = scenario.Children.Item('ReallyBad');
    priority  = scenario.Children.Item('Priority');

    %Compute Acesses
    littleBad.ComputeAccesses();
    reallyBad.ComputeAccesses();
    priority.ComputeAccesses();
    
    %Get Data Providers
    dpLB = littleBad.DataProviders.Item('Access Duration');
    dpRB = reallyBad.DataProviders.Item('Access Duration');
    dpP  = priority.DataProviders.Item('Access Duration');
    resultsLB = dpLB.Exec;
    resultsRB = dpRB.Exec;
    resultsP  = dpP.Exec;

    %Extract total coverage time
    durationLB = resultsLB.DataSets.GetDataSetByName('Duration').GetValues;
    durationLB = sum(cell2mat(durationLB));
    durationRB = resultsRB.DataSets.GetDataSetByName('Duration').GetValues;
    durationRB = sum(cell2mat(durationRB));
    durationP  = resultsP.DataSets.GetDataSetByName('Duration').GetValues;
    durationP  = sum(cell2mat(durationP));

    coverageTimes = [durationLB, durationRB, durationP];
end