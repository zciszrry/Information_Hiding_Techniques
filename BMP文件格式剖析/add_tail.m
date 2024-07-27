function Method2()
    x=input('请输入载体图像：','s'); % 载体图像
    m=input('请输入要隐藏的秘密信息图像：','s'); % 水印图像
    WaterMarked=Hide(x,m);
    watermark=Extract(WaterMarked);
end

function WaterMarked = Hide(origin,watermark)
    % 读取载体图像数据
    fidx=fopen(origin,'r');
    [x,xlength]=fread(fidx,inf,'uint8');
    fclose(fidx);

    % 读取水印图像数据
    fidm=fopen(watermark,'r');
    [m,mlength]=fread(fidm,inf,'uint8');
    fclose(fidm);

    % 写入所有数据到新的图像文件
    fid=fopen('Method2_watermarked.bmp','w');
    fwrite(fid,x);
    fwrite(fid,m);
    fclose(fid);

    % 读取生成的水印图像
    WaterMarked=imread('Method2_watermarked.bmp');

    % 显示生成的水印图像
    figure;
    imshow(WaterMarked,[]);
    title("WaterMarked Image");
    WaterMarked="Method2_watermarked.bmp";
end

function WaterMark=Extract(WaterMarked)
    % 读取水印信息位置和长度
    fid=fopen(WaterMarked,'r');
    fseek(fid,2,"bof");
    moffset=fread(fid,1,'uint32');
    fseek(fid,moffset+2,"bof");
    mlen=fread(fid,1,"uint32");

    % 读取水印信息
    fseek(fid,moffset,"bof");
    fWaterMark=fread(fid,mlen,'uint8');
    fclose(fid);

    % 将水印信息写入文件
    mfid=fopen("method2_watermark.bmp",'w');
    fwrite(mfid,fWaterMark,'uint8');
    fclose(mfid);

    % 读取生成的水印图像
    WaterMark=imread('method2_watermark.bmp');
    % 显示水印图像
    figure;
    imshow(WaterMark,[]);
    title("WaterMark");
end
