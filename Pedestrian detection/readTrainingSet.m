function [ X,y ] = readTrainingSet( filepath,numOfImages,extension,size)

if nargin < 2
    numOfImages =  6000;
end
if nargin < 3
    extension = {'.jpg', '.png', '.ppm','.tiff'};
end
if nargin < 4
    size =   [128 64];
end


%READTRAININGSET takes a path and reads all the images in it
%filepathExtension=strcat(filepath,'\*.',extension);
X=zeros(numOfImages,size(1)*size(2));
numPosExamples=0;
numNegExamples=0;
index=1;
for c=1:2,
    folder={'\pos','\neg'};
    filepathExtension=strcat(strcat(filepath,folder{c}));
    imagefiles = dir(filepathExtension);
    nfiles = length(imagefiles);    % Number of files found
    for i=1:nfiles
        currentFileName = imagefiles(i).name;
        [~,~,ext] = fileparts(strcat(filepathExtension,'\',currentFileName));
        if(sum(ismember(extension,ext))==0)
            continue;
        end
        currentImage = imread(strcat(filepathExtension,'\',currentFileName));
        if (ndims(currentImage)==3)
            grayImage=rgb2gray(currentImage);
        else
            grayImage = currentImage;
        end
%         if(index==4343)
%             nfiles;
%         end
        grayImage=imresize(grayImage,size);
        vecGrayImage=grayImage(:);
        X(index,:)=vecGrayImage;
        index=index+1;
        if(c==1)
            numPosExamples=numPosExamples+1;
        else
            numNegExamples=numNegExamples+1;
        end
    end
end
X = X(1:numPosExamples+numNegExamples,:);
y=[ones(numPosExamples,1) ;zeros(numNegExamples,1)];
end

