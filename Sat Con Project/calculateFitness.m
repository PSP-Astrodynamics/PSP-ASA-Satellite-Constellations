function [fitness] = calculateFitness(population, timeInAreas, totalMissionTime)

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

assert(height(population) == height(timeInAreas), 'height of arrays dont match');
assert(isscalar(totalMissionTime), 'mission time isnt scalar');
%assert(length(population)==5, "length of pop invalid");
assert(length(timeInAreas)==3, 'timeInAreas vector isnt length 3');

fitness = zeros(height(population),1);

for i = 1:height(population)

    score = 0;
    if population(i,1)*population(i,2)>20 && population(i,1)*population(i,2)<2000 % planes * slots gives total number of satellites
        score = 1;
    end
    fitness(i) = fitness(i) + score * weight.orbs;

    % add time in good areas
    assert(timeInAreas(i,1)/totalMissionTime <= 1  , strcat('time (' ,int2str(i) , ',good) exceeds mission time'));
    assert(timeInAreas(i,1)/totalMissionTime >= 0  , strcat('time (' ,int2str(i) , ',good) is negative'));
    score = timeInAreas(i,1)/totalMissionTime;
    fitness(i) = fitness(i) + score* weight.goodArea;

    % subtract time in bad areas
    assert(timeInAreas(i,1)/totalMissionTime <= 1  , strcat('time (' ,int2str(i) , ',bad) exceeds mission time'));
    assert(timeInAreas(i,1)/totalMissionTime >= 0  , strcat('time (' ,int2str(i) , ',bad) is negative'));
    score = 1 - timeInAreas(i,2)/totalMissionTime;
    fitness(i) = fitness(i) + score * weight.badArea;

    % subtract time in reallybad areas
    assert(timeInAreas(i,1)/totalMissionTime <= 1  , strcat('time (' ,int2str(i) , ',reallybad) exceeds mission time'));
    assert(timeInAreas(i,1)/totalMissionTime >= 0  , strcat('time (' ,int2str(i) , ',reallybad) is negative'));
    score = 1 - timeInAreas(i,3)/totalMissionTime;
    fitness(i) = fitness(i) + score * weight.reallyBadArea;

end

end