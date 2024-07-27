%% decode
clc;
clear;

% 读取带水印的二值图像
d = imread('scret.bmp');

% 初始化秘密信息数组
s = zeros(1, 24);

% 解析水印信息
t = 1;
num = 1;

while t < 24
    % 获取当前位置周围的黑色像素数量
    a = CalculateBlack(d, num);
    
    % 根据黑色像素数量确定水印位的值
    switch a
        case 0
            % 周围没有黑色像素，当前水印位保持不变
            num = num + 4;
        case 1
            % 周围有一个黑色像素，水印位为1
            s(t) = 1;
            t = t + 1;
            num = num + 4;
        case 3
            % 周围有三个黑色像素，水印位为0
            s(t) = 0;
            t = t + 1;
            num = num + 4;
        case 4
            % 周围有四个黑色像素，跳过当前位
            num = num + 4;
    end
    disp(t);
end

% 将二进制数组转换为十进制数，恢复出原始的秘密信息
sum = 0;
for t = 1:24
    sum = sum + s(t) * 2^(t - 1);
end

% 打印出解码得到的秘密信息
fprintf("秘密信息是：%d\n", sum);
