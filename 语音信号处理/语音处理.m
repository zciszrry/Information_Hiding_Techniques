% %读取音频文件
% [audioData, sampleRate] = audioread('sheep.wav');

% %播放音频
% %sound(audioData, sampleRate);

% %波形
% time = (0:length(audioData)-1) / sampleRate;
% plot(time, audioData);
% xlabel('Time (s)');
% ylabel('Amplitude');
% title('Audio Waveform'); 

%---------------------------------------------------------------------

% [x, f] = audioread('sheep.wav');
% N = length(x); % 信号的长度
% X = fft(x); % 进行傅里叶变换
% frequencies = linspace(-f/2, f/2, N); % 计算频率轴
% plot(frequencies, fftshift(abs(X))); % 绘制频谱
% xlabel('Frequency (Hz)');
% ylabel('Magnitude');
% title('Audio Spectrum');

%-------------------------------------------------------------------------

% % 读取音频文件
% [a, fs] = audioread("sheep.wav");
% 
% % 进行小波变换
% [ca1, cd1] = dwt(a(:, 1), 'db4');
% 
% % 逆小波变换并重构原始信号
% a0 = idwt(ca1, cd1, 'db4', length(a(:, 1)));
% 
% % 绘图
% figure;
% subplot(2, 2, 1); plot(a(:, 1)); title('(1) 原始波形');
% subplot(2, 2, 2); plot(cd1); title('(2) 细节分量');
% subplot(2, 2, 3); plot(ca1); title('(3) 近似分量');
% subplot(2, 2, 4); plot(a0); title('(4) 重构结果');

%------------------------------------------------------------
% % 读取音频文件
% [a, fs] = audioread("sheep.wav");
% 
% % 进行二级小波分解
% [C, L] = wavedec(a(:, 1), 2, 'db4');
% 
% % 提取二级分解的近似系数和细节系数
% ca2 = appcoef(C, L, 'db4', 2);
% cd2 = detcoef(C, L, 2);
% 
% ca1 = appcoef(C, L, 'db4', 1);
% cd1 = detcoef(C, L, 1);
% 
% % 逆小波变换并重构原始信号
% a0 = waverec(C, L, 'db4');
% 
% % 绘图
% figure;
% 
% % 定义子图标题
% titles = {'原始波形', '细节分量1', '近似分量1', '细节分量2', '近似分量2', '重构结果'};
% 
% for i = 1:6
%     % 绘制子图
%     subplot(3, 2, i);
%     switch i
%         case 1
%             plot(a(:, 1)); % 原始波形
%         case 2
%             plot(cd1); % 细节分量1
%         case 3
%             plot(ca1); % 近似分量1
%         case 4
%             plot(cd2); % 细节分量2
%         case 5
%             plot(ca2); % 近似分量2
%         case 6
%             plot(a0); % 重构结果
%     end
%     title(['(', num2str(i), ') ', titles{i}]); % 添加标题
% end

%---------------------------------------------------------------------
% 
% % 读取音频文件
% [a, fs] = audioread('sheep.wav');
% 
% % 进行三级小波分解
% [c, l] = wavedec(a(:, 2), 3, 'db4');
% 
% % 提取分解结果中的近似系数和细节系数
% ca3 = appcoef(c, l, 'db4', 3);
% cd3 = detcoef(c, l, 3);
% cd2 = detcoef(c, l, 2);
% cd1 = detcoef(c, l, 1);
% 
% % 逆小波变换并重构原始信号
% a0 = waverec(c, l, 'db4');
% 
% % 绘图
% figure;
% 
% % 定义子图标题
% titles = {'原始信号', '三级分解近似分量', '一级分解细节分量', ...
%           '二级分解细节分量', '三级分解细节分量', '重构结果'};
% 
% for i = 1:6
%     % 绘制子图
%     subplot(3, 2, i);
%     switch i
%         case 1
%             plot(a(:, 2)); % 原始信号
%         case 2
%             plot(ca3); % 三级分解近似分量
%         case 3
%             plot(cd1); % 一级分解细节分量
%         case 4
%             plot(cd2); % 二级分解细节分量
%         case 5
%             plot(cd3); % 三级分解细节分量
%         case 6
%             plot(a0); % 重构结果
%     end
%     title(['(', num2str(i), ') ', titles{i}]); % 添加标题
% end

%------------------------------------------------------------------
% % 读取音频文件
% [a, fs] = audioread('sheep.wav');
% 
% % 对第一列音频数据进行离散余弦变换（DCT）
% dct_a = dct(a(:, 1));
% 
% % 逆离散余弦变换（IDCT）以重构原始信号
% a0 = idct(dct_a);
% 
% % 绘图
% figure;
% 
% % 定义子图标题
% titles = {'原始波形', 'DCT处理后的波形', '重构得到的结果'};
% 
% for i = 1:3
%     % 绘制子图
%     subplot(3, 1, i);
%     switch i
%         case 1
%             plot(a(:, 1)); % 原始波形
%         case 2
%             plot(dct_a); % DCT处理后的波形
%         case 3
%             plot(a0); % 重构得到的结果
%     end
%     title(['(', num2str(i), ') ', titles{i}]); % 添加标题
% end
% 
% % 设置子图标题
% axes_handle = get(gcf, 'children');
% axes(axes_handle(3)); title('(1) wav original');
% axes(axes_handle(2)); title('(2) wav dct');
% axes(axes_handle(1)); title('(3) wav recover');

%--------------------------------------------------------------

% 读取音频文件
[a, fs] = audioread('sheep.wav');

% 绘制原始音频波形
subplot(6, 1, 1);
plot(a);
title('原始音频波形');

% 进行傅立叶变换（FFT）并绘制幅度谱
fx = fft(a);
subplot(6, 1, 2);
plot(abs(fftshift(fx)));
title('傅立叶变换幅度谱');

% 进行小波变换（DWT）并绘制分解结果
[ca1, cd1] = dwt(a(:, 1), 'db4');
a0 = idwt(ca1, cd1, 'db4', length(a(:, 1)));
subplot(6, 1, 3);
plot(a(:, 1));
title('原始信号');
subplot(6, 1, 4);
plot(cd1);
title('细节分量');
subplot(6, 1, 5);
plot(ca1);
title('近似分量');
subplot(6, 1, 6);
plot(a0);
title('重构结果');

% 进行离散余弦变换（DCT）并绘制变换结果
res = dct(a(:, 1));
figure;
plot(res);
title('离散余弦变换结果');

