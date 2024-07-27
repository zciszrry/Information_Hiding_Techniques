function Binary_images()
path = input("请输入要加密的图片：", 's'); 
origin = imread(path);

% Divide the original image into two encrypted images
[image1, image2] = divideImage(origin);

% Display the original image, image1, and image2
figure;
imshow(origin);
figure;
imshow(image1);
figure;
imshow(image2);


% Merge image1 and image2 to recover the original image
recoveredImage = mergeImages(image1, image2);

% Display the recovered image
figure;
imshow(recoveredImage);

end

function [image1, image2] = divideImage(image)
% Initialize
Size = size(image);
x = Size(1);
y = Size(2);
image1 = zeros(2*x, 2*y);
image1(:, :) = 255;
image2 = zeros(2*x, 2*y);
image2(:, :) = 255;

% Take image1 as the first
for i = 1:x
    for j = 1:y
        key = randi(3);
        son_x = 1 + 2 * (i - 1);
        son_y = 1 + 2 * (j - 1);
        switch key
            case 1
                image1(son_x, son_y) = 0; 
                image1(son_x, son_y + 1) = 0;
                if image(i, j) == 0
                    % Original is black
                    image2(son_x+1, son_y) = 0; 
                    image2(son_x+1, son_y+1) = 0;
                else
                    % Original is white
                    image2(son_x, son_y+1) = 0; 
                    image2(son_x+1, son_y+1) = 0;
                end
            case 2
                image1(son_x, son_y) = 0; 
                image1(son_x+1, son_y+1) = 0;
                if image(i, j) == 0
                    % Original is black
                    image2(son_x, son_y+1) = 0; 
                    image2(son_x+1, son_y) = 0;
                else
                    % Original is white
                    image2(son_x, son_y) = 0; 
                    image2(son_x+1, son_y) = 0;
                end
            case 3
                image1(son_x, son_y) = 0; 
                image1(son_x+1, son_y) = 0;
                if image(i, j) == 0
                    % Original is black
                    image2(son_x, son_y+1) = 0; 
                    image2(son_x+1, son_y+1) = 0;
                else
                    % Original is white
                    image2(son_x, son_y) = 0; 
                    image2(son_x, son_y+1) = 0;
                end
        end
    end
end

end

function mergedImage = mergeImages(image1, image2)
Size = size(image1);
x = Size(1);
y = Size(2);
mergedImage = zeros(x, y);
mergedImage(:, :) = 255;

for i = 1:x
    for j = 1:y
        mergedImage(i, j) = image1(i, j) & image2(i, j);
    end
end

end
