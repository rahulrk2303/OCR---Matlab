close all;
clear all;

[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
a=imread(s);
imshow(a);

b = ocr(a);
b.Text

c = insertObjectAnnotation(a, 'rectangle', ...
    b.WordBoundingBoxes, b.Words);

imshow(c);
tts(b.Text);
