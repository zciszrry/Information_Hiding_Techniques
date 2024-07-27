function HideAndExtract()
    x = imread('nilu_gray_image.jpg'); % 载体图像
    y = imread('fox_binary_image.jpg'); % 秘密信息图像

    % 裁剪图像为相同尺寸
    [Mc, Nc, ~] = size(x);
    [Mm, Nm, ~] = size(y);
    min_rows = min(Mc, Mm);
    min_cols = min(Nc, Nm);
    start_row = floor((Mc - min_rows) / 2) + 1; % 计算裁剪后图像的起始行
    start_col = floor((Nc - min_cols) / 2) + 1; % 计算裁剪后图像的起始列
    x = x(start_row:start_row+min_rows-1, start_col:start_col+min_cols-1); % 裁剪载体图像
    y = y(1:min_rows, 1:min_cols); % 裁剪秘密信息图像

    y = imbinarize(y); % 二值化秘密信息图像
    [m, n] = size(y); % 获取秘密信息图像的尺寸

    subplot(2, 2, 1);
    imshow(x);
    title('原始图像');

    subplot(2, 2, 2);
    imshow(y);
    title('水印图像');

    x = Hide(x, m, n, y);
    subplot(2, 2, 3);
    imshow(x, []);
    title('伪装图像');

    t = Extract();
    subplot(2, 2, 4);
    imshow(t, []);
    title('提取出的水印图像');
end

% 计算特定一维向量的第m个区域的最低位的校验和
function out = checksum(x, i, j)
    [rows, cols] = size(x);
    indices = [2*i-1, 2*j-1, 2*i-1, 2*j, 2*i, 2*j-1, 2*i, 2*j];
    temp = zeros(1, 4);
    for k = 1:4
        row = indices(2*k-1);
        col = indices(2*k);
        if row >= 1 && row <= rows && col >= 1 && col <= cols
            temp(k) = bitget(x(row, col), 1); % 获取指定位置的最低位
        end
    end
    out = rem(sum(temp), 2); % 计算校验和
end

function result = Hide(x, m, n, y)
    [rows, cols] = size(x);
    for i = 1:m
        for j = 1:n
            row = 2*i-1;
            col = 2*j-1;
            if row >= 1 && row <= rows && col >= 1 && col <= cols && checksum(x, i, j) ~= y(i, j) % 如果校验和不匹配
                random = int8(rand() * 3);
                switch random % 随机选择一个位置进行位反转
                    case 0
                        x(row, col) = bitset(x(row, col), 1, ~bitget(x(row, col), 1));
                    case 1
                        x(row, col+1) = bitset(x(row, col+1), 1, ~bitget(x(row, col+1), 1));
                    case 2
                        x(row+1, col) = bitset(x(row+1, col), 1, ~bitget(x(row+1, col), 1));
                    case 3
                        x(row+1, col+1) = bitset(x(row+1, col+1), 1, ~bitget(x(row+1, col+1), 1));
                end
            end
        end
    end
    imwrite(x, 'watermarkedImage.bmp'); % 保存水印图像
    result = x;
end

function out = Extract()
    c = imread('watermarkedImage.bmp');
    [m, n] = size(c);
    secret = zeros(m/2, n/2);
    for i = 1:m/2
        for j = 1:n/2
            secret(i, j) = checksum(c, i, j); % 提取水印信息
        end
    end
    out = secret;
end
