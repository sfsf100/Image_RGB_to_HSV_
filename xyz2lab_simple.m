% XYZ to LAB conversion (simplified version)
% XYZ: XYZ input values, mxnx3 or nx3 array
% XYZw: XYZ of reference white, 1x3 array
% Lab: Lab output values, mxnx3 or nx3 array

function Lab = xyz2lab_simple(XYZ, XYZw)

% reshape the input data
dims = ndims(XYZ); % check XYZ dimension
if  dims == 3 % if XYZ is a 3D array
    [height, width, ch] = size(XYZ); % check the size of XYZ array
    XYZ = reshape(XYZ, height*width, ch); % reshape the XYZ array to 2D
end

% XYZ to Lab calcuation
L = 100*((XYZ(:,2)/XYZw(2)).^(1/3));
a = 500*((XYZ(:,1)/XYZw(1)).^(1/3)-(XYZ(:,2)/XYZw(2)).^(1/3));
b = 200*((XYZ(:,2)/XYZw(2)).^(1/3)-(XYZ(:,3)/XYZw(3)).^(1/3));
Lab = [L a b];

% reshape the output data
if dims == 3 % if the input XYZ is in a 3D array
    Lab = reshape(Lab, height, width, ch); % reshape the Lab array to 3D
end