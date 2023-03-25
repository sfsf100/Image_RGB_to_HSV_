% LAB to XYZ conversion (simplified version)
% Lab: Lab input values, mxnx3 or nx3 array
% XYZw: XYZ of reference white, 1x3 array
% XYZ: XYZ output values, mxnx3 or nx3 array

function XYZ = lab2xyz_simple(Lab, XYZw)

% reshape the input data
dims = ndims(Lab); % check Lab dimension
if  dims == 3 % if Lab is a 3D array
    [height, width, ch] = size(Lab); % check the size of Lab array
    Lab = reshape(Lab, height*width, ch); % reshape the Lab array to 2D
end

% LAB to XYZ conversion
Y = (Lab(:,1)/100).^3*XYZw(2);
X = ((Lab(:,2)/500)+(Y/XYZw(2)).^(1/3)).^3*XYZw(1);
Z = (-(Lab(:,3)/200)+(Y/XYZw(2)).^(1/3)).^3*XYZw(3);
XYZ = [X Y Z];

% reshape the output data
if dims == 3 % if the input XYZ is in a 3D array
    XYZ = reshape(XYZ, height, width, ch); % reshape the XYZ array to 3D
end