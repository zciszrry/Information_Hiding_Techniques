% 读取图像并转换为灰度图像
b = imread("lov.png");
b = rgb2gray(b);

% 显示原图像
figure;
imshow(b);
title('(a)原图像');

% 对灰度图像进行二值化处理
I = imbinarize(b);

% 进行离散余弦变换
c = dct2(I);

% 显示DCT变换系数
figure;
imshow(c);
title('(b)DCT变换系数');

% 绘制DCT变换系数的立体视图
figure;
mesh(c);
title('(c)DCT变换系数（立体视图）');
