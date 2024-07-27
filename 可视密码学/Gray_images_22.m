function Gray_images_22()
path = input("请输入要加密的图片：", 's'); 
origin = imread(path);

figure(1);
imshow(origin);
title('原图');

gray=rgb2gray(origin);
figure(2);
imshow(gray);
title('灰度图像');

origin_bw = error_diffusion_dithering(gray);
figure(3);
imshow(origin_bw);
title('半色调图像');

[image1,image2] = divideImage(origin_bw);
figure(4);
imshow(image1);
title('子图1');

figure(5);
imshow(image2);
title('(子图二');

result = mergeImages(image1,image2);
figure(6);
imshow(result);
title('复原图像');

end

function out_image = error_diffusion_dithering(gray_image)
    [X, Y] = size(gray_image);
    out_image = zeros(X, Y); % 初始化输出图像

    for m = 1:X
        for n = 1:Y
            if gray_image(m, n) > 127
                out = 255;
            else
                out = 0;
            end
            error = gray_image(m, n) - out;
            
            out_image(m, n) = out; % 将当前像素设置为输出值
            
            % 误差传播
            if n < Y % 右方
                gray_image(m, n+1) = gray_image(m, n+1) + error * 7 / 16.0;
            end
            if m < X && n > 1 % 左下方
                gray_image(m+1, n-1) = gray_image(m+1, n-1) + error * 3 / 16.0;
            end
            if m < X % 下方
                gray_image(m+1, n) = gray_image(m+1, n) + error * 5 / 16.0;
            end
            if m < X && n < Y % 右下方
                gray_image(m+1, n+1) = gray_image(m+1, n+1) + error * 1 / 16.0;
            end
        end
    end
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
