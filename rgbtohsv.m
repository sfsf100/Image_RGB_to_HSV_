close all;
clc,clear;
%12/8 finish
% Abnormal color 
%Make by 12/7 ,HW.2. 
im=imread('ballon.jpg');
rgb=imresize(im,[500,500]); %scaledown
RGB=double(rgb); % double type
% RGB=reshape(ad,500*500,3);  %change to 2D
%First transfer RGB to XZY
%extract RGB Channel
R=RGB(:,:,1)/255;
G=RGB(:,:,2)/255;
B=RGB(:,:,3)/255;

%Linearlization
r=R.^2.2;
g=G.^2.2;
b=B.^2.2;

XYZw=[0.95,1.0,1.09]; %input white
[M, N] = size(R);% get widtg and high
s = M * N; %image dimension
 RGBe = [reshape(r,1,s); reshape(g,1,s); reshape(b,1,s)]; %scale 500x500
% 
% % RGB to XYZ
 MAT = [0.412453 0.357580 0.180423;
        0.212671 0.715160 0.072169;
        0.019334 0.119193 0.950227];
 XYZ = MAT * RGBe; %Color conversion


% Normalize for D65 white point
X = XYZ(1,:) ;
Y = XYZ(2,:);
Z = XYZ(3,:);
x=reshape(X,500,500);
y=reshape(Y,500,500);
z=reshape(Z,500,500);
xyznew=cat(3,x,y,z);

Lab = xyz2lab_simple(xyznew, XYZw);

l=Lab(:,:,1); % get l channel
a=Lab(:,:,2); % get a channel
b=Lab(:,:,3); % get b channel

%  Color Conversion
 
Cab=sqrt(a.^2+b.^2);     % Chroma formula 
h = mod((180/pi)*atan2(b, a), 360); % Hue channel
                                
F=zeros(500,500);% set to 0 matrix
anew=F+128;
bnew=b+128;
cnew=Cab*2;
hnew=(255/360)*h;
Lnew=2.55*l;
% transfer to int type
L8=uint8(Lnew);
h8=uint8(hnew);
a8=uint8(anew);
b8=uint8(bnew);
c8=uint8(cnew);
 
% show anyone gray_level images
figure(),imshow(L8);
figure(),imshow(a8);
figure(),imshow(b8);
figure(),imshow(h8);
figure(),imshow(c8);

 newlab=cat(3,l,F,b); % combine  3 channel
 XYZn = lab2xyz_simple(newlab, XYZw); % use function
 RGBnn = xyz2rgb(XYZn); % use function
% 
% xx= XYZn(:,:,1);
% yy= XYZn(:,:,2);
% zz= XYZn(:,:,3);
% q=[reshape(xx,1,s); reshape(yy,1,s); reshape(zz,1,s)];
% RGBN = (MAT')\q ;
% rgbt = reshape(RGBN, 500, 500, 3); % reshape the Lab array to 3D
% mm=rgbt.^(1/2.2);

% rw=mm(:,:,1)*255;
% gw=mm(:,:,2)*255;
% bw=mm(:,:,3)*255;
% 
% final=cat(3,rw,gw,bw);
ff=real(RGBnn); 
fa=imresize(ff,[480,640]); %change to original size
fop=uint8(fa); % transfer to int type
figure(),imshow(fop);
imwrite(fop,'abnormal.jpg','jpg'); %store int image 
