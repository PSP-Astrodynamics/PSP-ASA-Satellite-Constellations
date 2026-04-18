function fitness = calculateFitness(x, timeInAreas, totalMissionTime)

% population is an (i) x [planes, slots, phase, inclination, RAAN] matrix
%
% timeInAreas is an (i) x
% [timeInGoodAreas,timeInBadAreas,timeInReallyBadAreas] matrix
%
% totalMissionTime is in seconds
%
% fitness is a i x 1 vector

% calculates the fitness of each (chromosone, individual, etc) based on the
% orbital parameters, and time spent in areas of interest

% fitness of 1 is the best, 0 is the worst

weight.orbs = 0.4;
weight.goodArea = 0.3;
weight.reallyBadArea = 0.2;
weight.badArea = 0.1;

%totalMissionTime = 86400; % for 1 day elapsed time


assert(isscalar(totalMissionTime), 'mission time isnt scalar');
%assert(length(population)==5, "length of pop invalid");
assert(length(timeInAreas)==3, 'timeInAreas vector isnt length 3');

fitness = 0;



    score = 0;
    if x(1)*x(2)>20 && x(1)*x(2)<2000 % planes * slots gives total number of satellites
        score = 1;
    end
    fitness = fitness + score * weight.orbs;

    % add time in good areas
    assert(timeInAreas(1)/totalMissionTime <= 1  , strcat('time (good) exceeds mission time'));
    assert(timeInAreas(1)/totalMissionTime >= 0  , strcat('time (good) is negative'));
    score = timeInAreas(1)/totalMissionTime;
    fitness = fitness + score* weight.goodArea;

    % subtract time in bad areas
    assert(timeInAreas(2)/totalMissionTime <= 1  , strcat('time (bad) exceeds mission time'));
    assert(timeInAreas(2)/totalMissionTime >= 0  , strcat('time (bad) is negative'));
    score = 1 - timeInAreas(2)/totalMissionTime;
    fitness = fitness + score * weight.badArea;

    % subtract time in reallybad areas
    assert(timeInAreas(3)/totalMissionTime <= 1  , strcat('time (reallybad) exceeds mission time'));
    assert(timeInAreas(3)/totalMissionTime >= 0  , strcat('time (reallybad) is negative'));
    score = 1 - timeInAreas(3)/totalMissionTime;
    fitness = fitness + score * weight.reallyBadArea;

end

