clear all;clc;

data_path='C:\Users\HIGUMA_LU\Desktop\SONO\UNCATE';
output_patch='C:\Users\HIGUMA_LU\Desktop\SONO\FANRK\';
data_CList=dir([data_path '\*.bmp']);

L=1;
for i=1:length(data_CList) 
    file_name=[data_path,'\', data_CList(i).name];
    img=imread(file_name);
    img=img(45:412,133:601);
    img=(img-32)*1.3;
    img(17:103,383:467)=0;
    %figure;
    %imshow(img);
    save_path=[output_patch,data_CList(i).name];
    imwrite(img,save_path,'BMP');

end
