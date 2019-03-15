img = imread ('18.jpg');
result = ocr(img)
word = result.Words
wordbox = result.WordBoundingBoxes(:,:)
figure;
I = insertObjectAnnotation(img, 'rectangle', wordbox, word);
imshow(I);
tts(result.Text);