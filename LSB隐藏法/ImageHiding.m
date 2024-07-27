function ImageHiding()
    % 读取载体图像
    x = imread("nilu_gray_image.jpg");
    % 读取水印图像
    m = imread("fox_binary_image.jpg");

    % 裁剪图像为相同尺寸
    [Mc, Nc, ~] = size(x);
    [Mm, Nm, ~] = size(m);
    min_rows = min(Mc, Mm);
    min_cols = min(Nc, Nm);
    x = x(1:min_rows, 1:min_cols);
    m = m(1:min_rows, 1:min_cols);

    % 显示载体图像
    figure;
    imshow(x,[]);
    title("Original Image");

    % 显示水印图像
    figure;
    imshow(m,[]);
    title("Watermark Image");

    % 添加水印
    WaterMarked = Hide(x, m);
    
    % 提取水印
    watermark = Extract(WaterMarked);
end

function WaterMarked = Hide(origin, watermark)
    % 获取原始图像尺寸
    [Mc, Nc, ~] = size(origin);
    % 创建用于存储水印图像的数组
    WaterMarked = uint8(zeros(Mc, Nc));

    % 将水印嵌入到原始图像中
    for i = 1:Mc
        for j = 1:Nc
            WaterMarked(i, j) = bitset(origin(i, j), 1, watermark(i, j));
        end
    end

    % 将嵌入水印后的图像保存为文件
    imwrite(WaterMarked, 'lsb_watermarked.bmp', 'bmp');

    % 显示嵌入水印后的图像
    figure;
    imshow(WaterMarked,[]);
    title("Watermarked Image");
end

function WaterMark = Extract(WaterMarked)
    % 获取嵌入水印后的图像尺寸
    [Mw, Nw, ~] = size(WaterMarked);
    % 创建用于存储提取水印后的数组
    WaterMark = uint8(zeros(Mw, Nw));

    % 提取水印
    for i = 1:Mw
        for j = 1:Nw
            WaterMark(i, j) = bitget(WaterMarked(i, j), 1);
        end
    end

    % 显示提取的水印图像
    figure;
    imshow(WaterMark,[]);
    title("Extracted Watermark");
end
