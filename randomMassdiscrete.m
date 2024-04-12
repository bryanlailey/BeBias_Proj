% Function that generates n B star masses from the discrete
% distribution consisting of 3:5 6:2:16 solar masses where the probability 
% of a mass being chosen follows the Salpeter IMF.
 
% Method: We choose n masses where each mass has a relative probability,
% p_m, according to the Salpeter IMF. First, the masses are normalized (the
% domain (0,1) is divided into appropriately sized sub-domains) by taking
% p_m of the ith mass and dividing it by the sum of the p_ms of all the 
% masses considered. n random numbers in the domain (0,1) are drawn, each
% of which generates a mass according to the subdomain it is in. The n 
% masses are returned as a column vector.  

% example rng(42) randomMassdiscrete(5) returns [3; 10; 5; 4; 3]

function massBestars = randomMassdiscrete(n)
    a = -2.35;
    massBestars = zeros(n,1);
    discreteMasses = [3 4 5 6:2:16];
    normalizedProbs = zeros(length(discreteMasses),1);
    randUniformdeviate = rand(n,1); 

    for i = 1:length(discreteMasses)
        normalizedProbs(i) = discreteMasses(i).^a ./ sum(discreteMasses.^a);
    end
    
    for j = 1:n
        if randUniformdeviate(j) < normalizedProbs(1)
            massBestars(j) = 3;
        elseif randUniformdeviate(j) < sum(normalizedProbs(1:2))
            massBestars(j) = 4;
        elseif randUniformdeviate(j) < sum(normalizedProbs(1:3))
            massBestars(j) = 5;
        elseif randUniformdeviate(j) < sum(normalizedProbs(1:4))
            massBestars(j) = 6;
        elseif randUniformdeviate(j) < sum(normalizedProbs(1:5))
            massBestars(j) = 8;
        elseif randUniformdeviate(j) < sum(normalizedProbs(1:6))
            massBestars(j) = 10;
        elseif randUniformdeviate(j) < sum(normalizedProbs(1:7))
            massBestars(j) = 12;
        elseif randUniformdeviate(j) < sum(normalizedProbs(1:8))
            massBestars(j) = 14;
        else 
            massBestars(j) = 16;
    end

end
