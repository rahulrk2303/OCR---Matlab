clear;
cam = webcam;
I = cam.snapshot;
figure;
imshow(I);

%RGB to Gray
I = rgb2gray(I);
results = ocr(I);
results.Text    

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

results = ocr(BW, 'TextLayout', 'Block');

keys = results.Words;
wordbox = results.WordBoundingBoxes(:,:);
Ikeys = insertObjectAnnotation(I, 'rectangle', wordbox, keys);
figure;
imshow(Ikeys);
clear;