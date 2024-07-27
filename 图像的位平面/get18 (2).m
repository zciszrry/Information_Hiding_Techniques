% 读取图像
img = imread("nilu.bmp");
[m, n] = size(img);

% 检查图像是否成功加载
if isempty(img)
    error("无法加载图像");
end

% 显示1到8位平面的结果
figure;
for k = 1:8
    layer_image=zeros(m,n);
    for i=1:m
        for j=1:n
            layer_image(i,j)=bitget()

    c = bitget(img, k);
    subplot(2, 4, k);
    colormap gray; % 设置灰度颜色映射
    imshow(c, [0 1]); % 设置显示范围为0到1
    title(['第', num2str(k), '个位平面']);
end
