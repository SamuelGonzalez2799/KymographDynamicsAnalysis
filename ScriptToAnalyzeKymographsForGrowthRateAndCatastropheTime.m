%The goal of this script is to analyze kymographs so that you can find the
%growth rate, time to catastrophe, length at catastorphe, etc. 
%%Need to make the code so it prints out each loop rather than at end...
%we need to on a loop, read in a file, have the user click some points for
%all growth events, and then print out data to excel. 
clear;
close;
clc;
outputFile="11-17-23Mal3dynamcisWith50nMColchicine.xlsx";%change this name...
secondsPerFrame=6;%seconds in between frames. 
pixelSize=0.16;%um/pixel
currentData=[];
OutputStart="B2";
textOutputStart="A2";
if isfile(outputFile)
    currentData=readmatrix(outputFile);
    startingIndex=size(currentData,1)+2;
    OutputStart=strcat("B",int2str(startingIndex));
    textOutputStart=strcat("A",int2str(startingIndex));
end
Titles=["Image Number","growth event number","growth rate","time to catastrophe","length at catastrophe","Full growth Event"];
writematrix(Titles,outputFile,'Range',"A1");
%Need to read the file and then use the info on how many rows there are to
%determine where to start saving out data. Then, make sure you print out
%data each loop. 
currentGrowthRate=0;
currentTimeToCat=0;
currentLengthAtCat=0;
growthEvent=0;
currentFullGrowthEvent=-1;
answer={1};
position=0;%keep track of position in OutputData
for i=1:50
    [image,path]=uigetfile('.tif');
    fprintf(image)
    fprintf('\n')
    A = imread(image,'tif');
    
    
    imshow(A, [],'InitialMagnification','fit')
    answer{1}=1;
    while answer{1}==1
        growthEvent=growthEvent+1;
        
        currentGrowthRate=0;
currentTimeToCat=0;
currentLengthAtCat=0;
currentFullGrowthEvent=-1;

        position=position+1;%to keep track of indexing. 
        f=msgbox("click at the start of the seed and the start of the growth event (2 points, don't double click) and then at the end of the growth event and the seed (2 points) in that order");
    [x,y,P]=impixel(A);
    if exist('f', 'var')
  delete(f);
  clear('f');
    end
    currentGrowthRate=((abs(x(4)-x(3))-abs(x(2)-x(1)))*pixelSize)/((mean(y(4),y(3))-mean(y(2),y(1)))*secondsPerFrame);
    currentTimeToCat=(mean(y(4),y(3))-mean(y(2),y(1)))*secondsPerFrame;%about 6 seconds per frame for imaging..
    currentLengthAtCat=abs(x(4)-x(3))*pixelSize;
    if abs(x(2)-x(1))<2 %essentially, if the first two points are super close to one another, then it's at the start of a growth event, otherwise it's partway through..
        currentFullGrowthEvent=1;
    else
        currentFullGrowthEvent=0;
    end
    
    outputData(position,1)=growthEvent;
        outputData(position,2)=currentGrowthRate;
    outputData(position,3)=currentTimeToCat;
        outputData(position,4)=currentLengthAtCat;
        outputData(position,5)=currentFullGrowthEvent;
        fileNames{position,1}=image;
writematrix(outputData,outputFile,'Range',OutputStart);
writecell(fileNames,outputFile,'Range',textOutputStart);
answer=inputdlg("Is there another growth event? If so, put 1. Otherwise, anything else will end the loop");
answer{1}=str2num(answer{1});
    end
    growthEvent=0;
end
