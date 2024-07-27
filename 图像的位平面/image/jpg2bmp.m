% 输入JPEG图像的文件名
jpgFileName = input('请输入JPEG图像的文件名（包括扩展名）：', 's');

% 读取JPEG图像
img = imread(jpgFileName);

% 检查图像是否成功加载
if isempty(img)
    error('无法加载图像');
end

% 将JPEG图像保存为BMP格式
bmpFileName = strrep(jpgFileName, '.jpg', '.bmp');
imwrite(img, bmpFileName, 'bmp');

disp(['已将 ', jpgFileName, ' 转换为 ', bmpFileName]);
