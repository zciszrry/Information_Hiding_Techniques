% % 读取图像
% b = imread("cat.jpg");
% 
% % 转换为灰度图像
% a = rgb2gray(b);
% 
% % 获取图像的行数
% nbcol = size(a, 1);
% 
% % 进行一级二维小波变换
% [ca1, ch1, cv1, cd1] = dwt2(a, 'db4');
% 
% % 对小波系数进行可视化处理
% cod_ca1 = wcodemat(ca1, nbcol);
% cod_ch1 = wcodemat(ch1, nbcol);
% cod_cv1 = wcodemat(cv1, nbcol);
% cod_cd1 = wcodemat(cd1, nbcol);
% 
% % 显示一级小波分解结果
% figure;
% image([cod_ca1, cod_ch1; cod_cv1, cod_cd1]);
% title('一级小波分解');

%---------------------------------------------------------------------

% 读取图像
b = imread("cat.jpg");

% 转换为灰度图像
a = rgb2gray(b);

% 获取图像的行数
nbc = size(a, 1);

% 进行一级二维小波变换
[ca1, ch1, cv1, cd1] = dwt2(a, 'db4');

% 对第一级小波系数进行二级小波变换
[ca2, ch2, cv2, cd2] = dwt2(ca1, 'db4');

% 对小波系数进行可视化处理
cod_ca1 = wcodemat(ca1, nbc);
cod_ch1 = wcodemat(ch1, nbc);
cod_cv1 = wcodemat(cv1, nbc);
cod_cd1 = wcodemat(cd1, nbc);
cod_ca2 = wcodemat(ca2, nbc);
cod_ch2 = wcodemat(ch2, nbc);
cod_cv2 = wcodemat(cv2, nbc);
cod_cd2 = wcodemat(cd2, nbc);

% 对第二级近似系数进行尺寸调整以匹配第一级近似系数的大小
tt = imresize([cod_ca2, cod_ch2; cod_cv2, cod_cd2], size(ca1));

% 显示二级小波分解结果
figure;
image([tt, cod_ch1; cod_cv1, cod_cd1]);
title('二级小波分解');

