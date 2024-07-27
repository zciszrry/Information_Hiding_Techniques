function RGB_images()
path = input("请输入要加密的图片：", 's'); 
origin = imread(path);

% 显示原始图像
figure(1);
imshow(origin);
title('原图');

% 分别处理彩色通道
[R, G, B] = splitRGB(origin);

% 对每个通道进行半色调处理并进行信息分存
[image1_R, image2_R] = divideImage(error_diffusion_dithering(R));
[image1_G, image2_G] = divideImage(error_diffusion_dithering(G));
[image1_B, image2_B] = divideImage(error_diffusion_dithering(B));

% 得到两张彩色子图像
image1_rgb = mergeRGB(image1_R, image1_G, image1_B);
figure;
imshow(image1_rgb);
title('子图1');

image2_rgb = mergeRGB(image2_R, image2_G, image2_B);
figure;
imshow(image2_rgb);
title('子图2');

result = mergeImages(image1_rgb,image2_rgb);
figure(6);
imshow(result);
title('复原图像');

end

function [R, G, B] = splitRGB(rgbImage)
    % 分离 R、G、B 通道
    R = rgbImage(:,:,1);
    G = rgbImage(:,:,2);
    B = rgbImage(:,:,3);
end

function rgbImage = mergeRGB(R, G, B)
    % 获取通道图像的大小
    [rows, cols] = size(R);
    
    % 创建一个空白的 RGB 图像
    rgbImage = zeros(rows, cols, 3);
    
    % 将分量放置在相应的通道位置上
    rgbImage(:, :, 1) = R; % 红色通道
    rgbImage(:, :, 2) = G; % 绿色通道
    rgbImage(:, :, 3) = B; % 蓝色通道
end

function image = error_diffusion_dithering(gray)
Size=size(gray);
x=Size(1);
y=Size(2);

for m=1:x
    for n=1:y
        if gray(m,n)>127
            out=255;
        else
            out=0;
        end
        error=gray(m,n)-out;
        if n>1 && n<255 && m<255
            gray(m,n+1)=gray(m,n+1)+error*7/16.0;  %右方
            gray(m+1,n)=gray(m+1,n)+error*5/16.0;  %下方
            gray(m+1,n-1)=gray(m+1,n-1)+error*3/16.0;  %左下方
            gray(m+1,n+1)=gray(m+1,n+1)+error*1/16.0;  %右下方
            gray(m,n)=out;
        else
            gray(m,n)=out;
        end
    end
end
image=gray;

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
    % 获取图像尺寸
    Size = size(image1);
    x = Size(1);
    y = Size(2);

    % 初始化合并后的图像
    mergedImage = zeros(x, y, 3);

    % 合并 R 通道
    mergedImage(:,:,1) = image1(:,:,1) & image2(:,:,1);
    % 合并 G 通道
    mergedImage(:,:,2) = image1(:,:,2) & image2(:,:,2);
    % 合并 B 通道
    mergedImage(:,:,3) = image1(:,:,3) & image2(:,:,3);
end


