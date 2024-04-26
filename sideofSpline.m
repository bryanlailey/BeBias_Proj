% Function receives a point with x,y coordinates (bex,bey) and a spline
% curve (spline) and takes the dot product between the normal to a 
% linearization of the spline with the same y-value as the point and
% a line connecting the point with the linearization. The sign of this quantity 
% can be compared to a known point to determine which side of the spline 
% the points lie on.

function det = sideofSpline(bex,bey,spline);

det = (bex - (slmsolve(spline,bey-0.005)-0.15))*(ppval(spline,slmsolve(spline,bey+0.005)) - ppval(spline,slmsolve(spline,bey-0.005)))...
    - (bey - ppval(spline,slmsolve(spline,bey-0.005)))*((slmsolve(spline,bey+0.005)-0.15) - (slmsolve(spline,bey-0.005)-0.15));

end