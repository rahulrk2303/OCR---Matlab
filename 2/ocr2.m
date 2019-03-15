clear all;
close all;
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
I=imread(s);
figure;
imshow(I);

%RGB to Gray
I = rgb2gray(I);   

%Binarization
BW = imbinarize(I);    
figure;
imshowpair(I, BW, 'montage');       

%Preprocessing for better recognition of text

%Background
background = imopen(I, strel('disk', 15));     

%Removing background
Icorrected = I - background;  

%Binarization
BW1=imbinarize(Icorrected);
figure;
imshowpair(Icorrected, BW1, 'montage');

marker = imerode(Icorrected, strel('line', 10, 0));
Iclean = imreconstruct (marker, Icorrected);
BW2 = imbinarize(marker, Icorrected);
BW2 = imbinarize(Iclean);
figure;
imshowpair (Iclean, BW2, 'montage');

results = ocr(BW2, 'TextLayout', 'Block');

regularExpr = '\d';
bboxes = locateText(results, regularExpr, 'UseRegexp', true);
digits = regexp (results.Text, regularExpr, 'match');
Idigits = insertObjectAnnotation(I,'rectangle', bboxes, digits);

figure
imshow(Idigits);
tts(results.Text);