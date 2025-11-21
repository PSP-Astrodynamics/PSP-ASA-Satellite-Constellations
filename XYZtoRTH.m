function [RTHVec] = XYZtoRTH(XYZVec, inc, raan, argp, f)
%% Function Header:
%{
Name: Kaushik Vudathu
Date: 01/30/25
Function Name: RTHtoXYZ
Description: Converts RTH to XYZ Frame

Output Variables: XYZVec

Input Variables: 

%}

theta = argp + f;

R1 = [cos(raan)*cos(theta) - sin(raan)*sin(theta)*cos(inc);
      sin(raan)*cos(theta) + cos(raan)*sin(theta)*cos(inc);
      sin(theta)*sin(inc)];

R2 = [-cos(raan)*sin(theta) - sin(raan)*cos(theta)*cos(inc);
      -sin(raan)*sin(theta) + cos(raan)*cos(theta)*cos(inc);
      cos(theta)*sin(inc)];

R3 = [sin(raan)*sin(inc);
      -cos(raan)*sin(inc);
      cos(inc)];

DCM = [R1, R2, R3];

RTHVec = (DCM.' * XYZVec.').';

end

