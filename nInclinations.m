% Function that generates n random inclinations from the sin(i) distribution,
% between 0 and 90 degrees. 
 
% Inclinations are the angle between a star's rotation axis and an observers 
% line of sight; the sin(i) distribution implies random orientations of 
% stellar rotation axes.

% Method: sin(i) is a normalized pdf between 0 and 90 degrees because 
% sin(i) / integral from 0 to 90 of sin(i)di equals sin(i). The cdf of sin(i)
% on this range is given by the integral from 0 to x of sin(i)di =
% 1-cos(i). We can set y, a random number in the domain (0,1), = the cdf and
% solve for i giving i = arccos(1-y).

function randomInclinations = nInclinations(n)
    randomInclinations = zeros(n,1);
    for j = 1:n
        randomInclinations(j) = acosd(1 - rand);
    end
end