% 读取图像
image = imread("nilu.bmp");
[m, n] = size(image);

% 复制图像
temp_image = image;

% 显示每个位平面并从图像中移除
figure;
for layer = 1:8
    for i = 1:m
        for j = 1:n
            % 移除低位平面
            temp_image(i, j) = bitset(temp_image(i, j), layer, 0);
        end
    end
    % 显示
    subplot(2, 4, layer);
    imshow(temp_image);
    title(['去掉前 ', num2str(layer), ' 层图像']);
end
