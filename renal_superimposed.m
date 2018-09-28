clc;clear all;close all;

img_dir='C:\Users\HIGUMA_LU\Desktop\SONO\dataset\gen_sample';
dust_dir='C:\Users\HIGUMA_LU\Desktop\SONO\OBJECT\15.bmp';
save_path='C:\Users\HIGUMA_LU\Desktop\SONO\gen_img';
ROI_X=[120 230];
ROI_Y=[250 355];
gen_num=10;
D_range=40;
THR1=90;        
THR2=1;
G = fspecial('average',[20 20]);
W_R=randi([1 30],1,gen_num);     %dust img rand size



 
 
data_list=dir([img_dir '\*.bmp']);

for n=1:length(data_list)
    X_R=randi([ROI_X(1) ROI_X(2)],1,gen_num);; %RAND 150-250
    Y_R=randi([ROI_Y(1) ROI_Y(2)],1,gen_num); %RAND 170-240
    
    %load image data & dust_image data
    original=double(imread([img_dir '\' data_list(n).name]));
    dust=double(rgb2gray(imread(dust_dir)));
    dust=(dust-128)*2;

    %{
    %Binarization
    bimg=original;
     for i=1:size(bimg,1)
        for j=1:size(bimg,2)
            if bimg(i,j)<THR1 & bimg(i,j)>THR2
            bimg(i,j)=1;
            else
            bimg(i,j)=0;    
            end
        end
     end

     bimg=bimg(X_ROI(1):X_ROI(2),Y_ROI(1):Y_ROI(2));
     figure;imshow(bimg);
     [BY,BX]=find(bimg);
     n=randi([0 length(BX)],1,gen_num);
     %}



     for i = 1:gen_num
        
        img=original;
        img_a=imfilter(original,G,'same');

        %imshow(img_a,[]);
        %Define coordinate
        D=[D_range+W_R(i) D_range+W_R(i)];
        X_O=[X_R(i)-D(1)+1 X_R(i)];
        Y_O=[Y_R(i)-D(2)+1 Y_R(i)];    

        %D=[425-Y_R(i),10+W_R(i)];     %Y,X     400-YR=shadowL

        dust=imresize(dust,D);


        THR_high=find(img_a(Y_O(1):Y_O(2),X_O(1):X_O(2))>THR1);
        THR_low=find(img_a(Y_O(1):Y_O(2),X_O(1):X_O(2))<THR2);

         if ~isempty(THR_high) | ~isempty(THR_low)
            continue;
         end

        %Oimg+Dimg
        img(Y_O(1):Y_O(2),X_O(1):X_O(2))=img(Y_O(1):Y_O(2),X_O(1):X_O(2))+dust;

        K=uint8(img);
        %imshow(K,[]);
        imwrite(K,[save_path '\' int2str(n) '_' int2str(i) '.bmp'],'BMP');

     end

end