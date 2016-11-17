% Ia = vl_impattern('roofs1') ;
% Ib = vl_impattern('roofs2') ;
% image([Ia,Ib]) ;
clear all
close all
Ia = imread('test_shell1.jpg');
Ib = imread('shell.jpg');

Iaa = single(rgb2gray(Ia));
Ibb = single(rgb2gray(Ib));
[fa, da] = vl_sift(Iaa) ;
[fb, db] = vl_sift(Ibb) ;
[matches, scores] = vl_ubcmatch(da,db,3.2);


% imagesc(cat(2, Ia, Ib)) ;

sb = size(Ia);
ss = size(Ib);
Im = Ia;
Im(1,end+ss(2),1)=0;
Im(1:ss(1),sb(2):sb(2)+ss(2)-1,:) = Ib;
imagesc(Im)

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

[tform, ind1, ind2] = estimateGeometricTransform([xa' ya'],[xb' yb'],'affine');
hold on ;
h = line([ind1(:,1)' ; ind2(:,1)'], [ind1(:,2)' ; ind2(:,2)']) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;