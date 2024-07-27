% 预处理图像
clc; clear all; close all;
img = (imread('gray_image.jpg'));  % 读取原始图像
watermark = imbinarize(imread('222.bmp'));  % 读取水印图像，并转为二值图像
img = imresize(img, [256, 256]);  % 调整原始图像大小为256x256
watermark = imresize(~watermark, [64, 64]);  % 调整水印图像大小为64x64，并取反

img = double(img) / 256;  % 将原始图像转为double类型，并归一化
watermark = im2double(watermark);  % 将水印图像转为double类型

size = 256; width = 4;  % 设置参数

blocks = size / width;  % 计算图像分块数
new_image = zeros(size);  % 初始化新图像
vec = ones(64);  % 初始化提取水印信息的向量

% 嵌入水印
for i = 1 : blocks
    for j = 1 : blocks
        x = (i - 1) * width + 1;
        y = (j - 1) * width + 1;
        cur = img(x:x+width-1, y:y+width-1);
        cur = dct2(cur);
        
        if watermark(i, j) == 0
            a = -1;
        else
            a = 1;
        end
        
        cur(1, 1) = cur(1, 1) * (1 + .01 * a) + .01 * a;
        cur = idct2(cur);
        new_image(x: x + width - 1, y : y + width - 1) = cur;
    end
end

% 提取水印
for i = 1 : blocks
    for j = 1 : blocks
        x = (i - 1) * width + 1;
        y = (j - 1) * width + 1;
        
        if new_image(x, y) > img(x, y)
            vec(i, j) = 1;
        else
            vec(i, j) = 0;
        end
    end
end

% 显示结果
subplot(231); imshow(img); title("原始图像");
subplot(232); imshow(watermark); title("水印图像");
subplot(233); imshow(imcomplement(watermark)); title("反色之前的水印图像");
subplot(234); imshow(new_image, []); title("嵌入水印");
subplot(235); imshow(vec, []); title("提取图像");
subplot(236); imshow(imcomplement(vec), []); title("提取图像后反色与原图对比");
