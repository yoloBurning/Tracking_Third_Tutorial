close all
clear all
ia = imread('pot.jpg');
ib = imread('test_pot1.jpg');
ia = imresize(ia, 1/8);
ib = imresize(ib, 1/4);
Ia = single(ia);
Ib = single(ib);


cellSize = 8 ;
hog_a = vl_hog(Ia, cellSize, 'verbose') ;
hog_b = vl_hog(Ib, cellSize, 'verbose');

imhog_a = vl_hog('render', hog_a, 'verbose') ;
imhog_b = vl_hog('render', hog_b, 'verbose') ;
clf ; imagesc(imhog_a) ; colormap gray ;figure;
imagesc(imhog_b) ; colormap gray ;

scores = vl_nnconv(hog_b,hog_a,[]);

[best, bestIndex] = max(scores(:));

[hy, hx] = ind2sub(size(scores), bestIndex) ;

x = (hx - 1) * cellSize + 1 ;
y = (hy - 1) * cellSize + 1 ;

modelWidth = size(hog_a, 1) ;
modelHeight = size(hog_a, 2) ;

detection = [
  x - 0.5 ;
  y - 0.5 ;
  cellSize * modelWidth - 0.5; 
  cellSize * modelHeight - 0.5; ] ;
imshow(ib)
rectangle('position',detection,'EdgeColor','r','LineWidth',3);