function [fitness] = calculateFitness(population, timeInGoodAreas, timeInBadAreas, timeInReallyBadAreas)

% population is an (i) x [planes, slots, phase, inclination, RAAN] matrix
% timeInGoodAreas is an (i) x [seconds] vector
% timeInBadAreas is an (i) x [seconds] vector
% timeInReallyBadAreas is an (i) x [seconds] vector

% calculates the fitness of each (chromosone, individual, etc) based on the
% orbital parameters, and time spent in areas of interest

weight.orbs = 0.4;
weight.goodArea = 0.3;
weight.reallyBadArea = 0.2;
weight.badArea = 0.1;

maxGoodTime = max(timeInGoodAreas);
maxBadTime = max(timeInBadAreas);
maxReallyBadTime = max(timeInReallyBadAreas);

fitness = zeros(size(population));

for i = 1:length(population)

    score = 0;
    if population(i,1)*population(i,2)>20 && population(i,1)*population(i,2)<2000 % planes * slots gives total number of satellites
        score = 1;
    end
    fitness(i) = fitness(i) + score * weight.orbs;

    score = 0;
    score = timeInGoodAreas(i)/maxGoodTime;
    fitness(i) = fitness(i) + score* weight.goodArea;

    score = 0;
    score = 1 - timeInBadAreas(i)/maxBadTime;
    fitness(i) = fitness(i) + score * weight.badArea;

    score = 0;
    score = 1 - timeInReallyBadAreas(i)/maxReallyBadTime;
    fitness(i) = fitness(i) + score * weight.reallyBadArea;

end

end