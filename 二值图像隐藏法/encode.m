clc;
clear;

% 读取原始二值图像
d = imread('fox_binary_image.jpg');
subplot(1, 2, 1); imshow(d, []); title('原始图片');

% 要隐藏的秘密数字
secret = 2113662;

% 将秘密数字转换为二进制数组
s = dec2bin(secret, 24) - '0';

num = 1;
t = 1;

while t < 24
    if s(t) == 0
        % 当前位为0时的处理逻辑
        switch CalculateBlack(d, num)
            case 0
                % 如果周围黑色像素数量为0，回退一位重新处理
                t = t - 1;
                num = num + 4;
            case {1, 2}
                % 如果周围黑色像素数量为1或2，选择合适的点插入数据
                temp = s(t) + 1;
                startnum = num;

                while temp < 3 && d(startnum) == s(t)
                    % 在连续的黑色像素中插入数据
                    d(startnum) = ~d(startnum);
                    temp = temp + 1;
                    startnum = startnum + 1;
                end

                num = num + 4;
            case 3
                % 如果周围黑色像素数量为3，直接跳过
                num = num + 4;
            case 4
                % 如果周围黑色像素数量为4，找到适合的点插入数据
                temp = 4;
                startnum = num;

                while temp > 3 && d(startnum) == s(t)
                    % 在连续的白色像素中插入数据
                    d(startnum) = ~d(startnum);
                    temp = temp - 1;
                    startnum = startnum + 1;
                end

                num = num + 4;
        end
    else
        % 当前位为1时的处理逻辑
        a = CalculateBlack(d, num);

        switch a
            case 0
                % 如果周围黑色像素数量为0，找到适合的点插入数据
                temp = 4;
                startnum = num;

                while temp > 3 && d(startnum) == s(t)
                    % 在连续的白色像素中插入数据
                    d(startnum) = ~d(startnum);
                    temp = temp - 1;
                    startnum = startnum + 1;
                end

                num = num + 4;

            case {1, 2}
                % 如果周围黑色像素数量为1或2，直接跳过
                num = num + 4;
            case 3
                % 如果周围黑色像素数量为3，找到适合的点插入数据
                temp = 1;
                startnum = num;

                while temp < 3 && d(startnum) == s(t)
                    % 在连续的白色像素中插入数据
                    d(startnum) = ~d(startnum);
                    temp = temp + 1;
                    startnum = startnum + 1;
                end

                num = num + 4;
            case 4
                % 如果周围黑色像素数量为4，回退一位重新处理
                t = t - 1;
                num = num + 4;
        end

    end
    %disp(t);
    t = t + 1;
end

% 保存带水印的图像
imwrite(d, 'scret.bmp', 'bmp')

subplot(1, 2, 2); imshow(d, []); title('水印');
