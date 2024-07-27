% 读取图像
originalImage = imread('cat.jpg');

% 转换为灰度图像
grayImage = rgb2gray(originalImage);
figure;
imshow(grayImage);

% 二值化处理
threshold = graythresh(grayImage);
binaryImage = imbinarize(grayImage, threshold);

% 对二值化后的图像应用二维快速傅里叶变换 fft2，并使用 fftshift 函数将零频分量移到频谱中心
fftImage = calculateFFT(binaryImage);

% 显示变换后的幅度谱
showAmplitudeSpectrum(fftImage);

% 绘制幅度谱的三维能量分布图
plot3DEnergyDistribution(fftImage);

% 计算二维快速傅里叶变换并移动零频分量到频谱中心
function fftImage = calculateFFT(image)
    fftImage = fftshift(fft2(image));
end

% 显示变换后的幅度谱
function showAmplitudeSpectrum(fftImage)
    amplitudeSpectrum = abs(fftImage);
    figure;
    imshow(log(1 + amplitudeSpectrum), []);
end

% 绘制幅度谱的三维能量分布图
function plot3DEnergyDistribution(fftImage)
    amplitudeSpectrum = abs(fftImage);
    [M, N] = size(amplitudeSpectrum);
    [X, Y] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
    figure;
    mesh(X, Y, amplitudeSpectrum);
    xlabel('Frequency (X)');
    ylabel('Frequency (Y)');
    zlabel('Amplitude');
    title('3D Energy Distribution of Amplitude Spectrum');
end
