clear all;
close all;

[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
img=imread(s);
img=rgb2gray(img);
result = ocr(img);
word = result.Words;
wordbox = result.WordBoundingBoxes(:,:);
figure;
I = insertObjectAnnotation(img, 'rectangle', wordbox, word);
imshow(I);

file = fopen('output.txt', 'wt');
fprintf(file,'%s\n',result.Text);
fclose(file);
winopen('output.txt');

out = string(result.Text);

tts(result.Text);