clc; close all;
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
I=imread(s);
figure;
imshow(I);

%RGB to Gray
I = rgb2gray(I);
  

%What went Wrong?

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
 

 results = ocr(BW1, 'TextLayout', 'Block');
 results.Text
 keys = results.Words;
 wordbox = results.WordBoundingBoxes(:,:);
 Ikeys = insertObjectAnnotation(I, 'rectangle', wordbox, keys);
 figure;
 imshow(Ikeys);
 %tts(results.Text);
 