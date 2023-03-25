function RGB = xyz2rgb(XYZ)
%12/9 Modify


RGB = zeros(size(XYZ));
% this is the same matrix used in rgb2xyz.m
M = [0.412453 0.357580 0.180423;
     0.212671 0.715160 0.072169;
     0.019334 0.119193 0.950227];
invM = inv(M);

for i=1:3
    RGB(:,:,i) = XYZ(:,:,1)*invM(i,1) + XYZ(:,:,2)*invM(i,2) + XYZ(:,:,3)*invM(i,3);
end

index1 = find(RGB > 0.0031308);
index2 = find(RGB <= 0.0031308);

RGB(index1) = 1.055 * ( RGB(index1).^(1/2.4) ) - 0.055;
RGB(index2) = 12.92 * RGB(index2);
% RGB = RGB*255;

% rgbt = reshape(RGBN, 500, 500, 3); % reshape the Lab array to 3D
% mm=rgbt.^(1/2.2);
RGB = round((RGB.^(1/2.2))*255);

end