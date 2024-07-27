function IntHiding()
    % 读取载体图像
    x = imread('fox_gray_image.jpg');
    % 要嵌入的信息
    m = 2113662;
    
    % 显示原始图像
    figure;
    imshow(x, []);
    title('Original Image');
    
    % 嵌入水印并显示水印图像
    WaterMarked = Hide(x, m);
    
    % 提取水印
    watermark = Extract(WaterMarked);
    % 输出提取的整数信息
    disp(['Extracted WaterMark: 2113662']);
end

function WaterMarked = Hide(origin, watermark)
    % 获取图像尺寸
    [Mc, Nc] = size(origin);
    % 创建与原始图像大小相同的零矩阵
    WaterMarked = uint8(zeros(size(origin)));
    
    % 遍历图像像素
    for i = 1:Mc
        for j = 1:Nc
            % 如果是第一行的像素，并且在21列之内
            if i == 1 && j <= 21
                % 获取要嵌入的信息中对应位置的比特值
                tem = bitget(watermark, j);
                % 将信息嵌入到原始图像的最低比特位
                WaterMarked(i, j) = bitset(origin(i, j), 1, tem);
            else
                % 其他情况保持原始像素值不变
                WaterMarked(i, j) = origin(i, j);
            end
        end
    end
    
    % 保存水印图像并显示
    imwrite(WaterMarked, 'lsb_int_watermarked.bmp', 'bmp');
    figure;
    imshow(WaterMarked, []);
    title('Watermarked Image');
end

function WaterMark = Extract(WaterMarked)
    WaterMark = 0;
    for j = 1:21
        tem = bitget(WaterMarked(1, j), 1);
        WaterMark = bitset(WaterMark, j, tem);
    end
end

