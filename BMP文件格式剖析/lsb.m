function LSB_ImageHiding()
    % 读取载体图像和水印图像
    x = imread("i_scream.bmp"); % 载体图像
    m = imread("star.bmp"); % 水印图像

    % 显示载体图像和水印图像
    figure;
    subplot(1, 2, 1);
    imshow(x, []);
    title("Original Image (Carrier)");

    subplot(1, 2, 2);
    imshow(m, []);
    title("Watermark Image");

    % 调用隐藏和提取水印的函数
    WaterMarked = Hide(x, m);
    watermark = Extract(WaterMarked);
end

function WaterMarked = Hide(origin, watermark)
    % 获取载体图像的大小
    [Mc, Nc] = size(origin);

    % 初始化水印图像
    WaterMarked = uint8(zeros(size(origin)));

    % 将水印嵌入到载体图像中
    for i = 1:Mc
        for j = 1:Nc
            WaterMarked(i, j) = bitset(origin(i, j), 1, watermark(i, j));
        end
    end

    % 保存带水印的图像
    imwrite(WaterMarked, 'lsb_watermarked.bmp', 'bmp');

    % 显示带水印的图像
    figure;
    imshow(WaterMarked, []);
    title("Watermarked Image");
end

function WaterMark = Extract(WaterMarked)
    % 获取带水印图像的大小
    [Mw, Nw] = size(WaterMarked);

    % 初始化提取的水印图像
    WaterMark = uint8(zeros(size(WaterMarked)));

    % 从带水印的图像中提取水印
    for i = 1:Mw
        for j = 1:Nw
            WaterMark(i, j) = bitget(WaterMarked(i, j), 1);
        end
    end

    % 显示提取的水印图像
    figure;
    imshow(WaterMark, []);
    title("Extracted Watermark");
end
