function [fitness] = calculateFitness(population, orbitParameters, targetAreas, avoidedAreas)

% calculates the fitness of each (chromosone, individual, etc) based on the
% orbital parameters, and time spent in areas of interest

weight.orbs = 0.4;
weight.goodArea = 0.3;
weight.badArea = 0.3;


fitness = zeros(size(population));

for i = 1:length(population)

    for j = 1:length(orbitParameters)
        %score = orbitParameters(j).population(i) * orbitParameters(j).nondimensionalizingFactor
    end
    fitness(i) = fitness(i) + score * weight.orbs;

    for k = 1:length(targetAreas)
        %score = %math here
    end
    fitness(i) = fitness(i) + score* weight.goodArea;

    for b = 1:length(avoidedAreas)
        %score = %math here
    end
    fitness(i) = fitness(i) + score * weight.badArea;

end

end