% 读取载体图像
image = imread('nilu.bmp');
% 读取消息图像
message = imread('fox.bmp');
[m, n] = size(message);

% 将消息隐藏到图像的第一位平面中
for i = 1:m
    for j = 1:n
        image(i, j) = bitset(image(i, j), 1, message(i, j));
    end
end

% 显示隐藏消息后的图像
figure;
imshow(image, []);
title('隐藏消息后的图像');

% 保存隐藏消息后的图像
imwrite(image, 'hide_image.png', 'png');

clc;
clear all;

% 从隐藏消息后的图像中提取隐藏的消息
image = imread('fox.bmp');
[m, n] = size(image);
x = zeros(m, n);
for i = 1:m
    for j = 1:n
        x(i, j) = bitget(image(i, j), 1);
    end
end

% 显示提取出的消息图像
figure;
imshow(x, []);
title('提取出的消息图像');
