% 读取图像
img = imread("nilu.bmp");

% 循环处理每个位平面数
for k = 1:8
    % 获取图像尺寸
    [a, b] = size(img);

    % 初始化两个新图像
    y = zeros(a, b);
    z = zeros(a, b);

    % 提取前 k 位平面
    for n = 1:k
        % 提取第 n 位平面
        for i = 1:a
            for j = 1:b
                x(i, j) = bitget(img(i, j), n);
            end
        end
        % 将第 n 位平面设置到 y 图像中
        for i = 1:a
            for j = 1:b
                y(i, j) = bitset(y(i, j), n, x(i, j));
            end
        end
    end

    % 提取剩余的位平面
    for n = k+1:8
        % 提取第 n 位平面
        for i = 1:a
            for j = 1:b
                x(i, j) = bitget(img(i, j), n);
            end
        end
        % 将第 n 位平面设置到 z 图像中
        for i = 1:a
            for j = 1:b
                z(i, j) = bitset(z(i, j), n, x(i, j));
            end
        end
    end

    % 在一个窗口中显示前 k 位平面和剩余位平面的图像
    figure;
    subplot(1, 2, 1);
    imshow(y, []);
    title(['前 ', num2str(k), ' 个位平面']);

    subplot(1, 2, 2);
    imshow(z, []);
    title(['剩余 ', num2str(8-k), ' 个位平面']);
end
