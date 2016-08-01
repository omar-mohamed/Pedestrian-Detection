function [ out ] = readTrainingSet( filepath,extension)
%READTRAININGSET takes a path and reads all the images in it
filepathExtension=strcat(filepath,'\*.',extension);
imagefiles = dir(filepathExtension);      
nfiles = length(imagefiles);    % Number of files found
for i=1:nfiles
   currentFileName = imagefiles(i).name;
   currentImage = imread(strcat(filepath,'\',currentFileName));
   grayImage=rgb2gray(currentImage);
   vecGrayImage=grayImage(:);
   if(i==1)
       out=zeros(nfiles,size(vecGrayImage,1));
   end
   out(i,:)=vecGrayImage;
end

end

