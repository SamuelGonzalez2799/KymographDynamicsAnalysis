%%%Written by SJG in the Gardner Lab. Copyright Gonzalez 2023
%%%The goal of this script is to analyze kymographs so that you can find the
%%%growth rate, time to catastrophe, length at catastorphe, etc. The code
%%%allows the user to pick kymographs out of the same directly as the
%%%Matlab file, click four points (two to determine the microtubule length
%%%and starting time initially and two points to determine the microtubule
%%%lenght and time at catastrophe) so that it can calculate the necessary
%%%quantifications. Of note, the user should make sure that the filename
%%%(outputFile), secondsPerFrame, and pixelSize match with their imaging
%%%conditions to ensure accurate quatifications. 

clear;
close;
clc;
%Generate file name, pixel size, and seconds per Frame. 
outputFile="ExampleOutputData.xlsx";%change this name...
secondsPerFrame=6;%seconds in between frames. 
pixelSize=0.16;%um/pixel
%Generate array to store data. 
currentData=[];
%initialize necessary variables. 
currentGrowthRate=0;
currentTimeToCat=0;
currentLengthAtCat=0;
growthEvent=0;
currentFullGrowthEvent=-1;
answer={1};
position=0;%keep track of position in OutputData

%Determine proper placement of new data in the excel sheet; check if the
%file exists and if it does, append to the end of it rather than at the
%start so that data is not erased.
OutputStart="B2";
textOutputStart="A2";
if isfile(outputFile)
    currentData=readmatrix(outputFile);
    startingIndex=size(currentData,1)+2;
    OutputStart=strcat("B",int2str(startingIndex));
    textOutputStart=strcat("A",int2str(startingIndex));
end
%Headers for the output file and write them to file. 
Titles=["Image Number","growth event number","growth rate um/s","time to catastrophe s ","length at catastrophe um","Full growth Event"];
writematrix(Titles,outputFile,'Range',"A1");
%Need to read the file and then use the info on how many rows there are to
%determine where to start saving out data. Then, make sure you print out
%data each loop. 


for i=1:50%on a per image basis
    %Open the image based on user input and show it. . 
    [image,path]=uigetfile('.tif');
    fprintf(image)
    fprintf('\n')
    A = imread(image,'tif');
    
    
    imshow(A, [],'InitialMagnification','fit')
    answer{1}=1;
    %for loop so you can measure multiple growth events per kymograph. 
    while answer{1}==1
        growthEvent=growthEvent+1;
        %resetting variables with each loop. 
        currentGrowthRate=0;
currentTimeToCat=0;
currentLengthAtCat=0;
currentFullGrowthEvent=-1;

        position=position+1;%to keep track of indexing. 
        %obtain data from user where MT starts and stops. 
        f=msgbox("click at the start of the seed and the start of the growth event (2 points, don't double click) and then at the end of the growth event and the seed (2 points) in that order");
    [x,y,P]=impixel(A);
    if exist('f', 'var')
  delete(f);
  clear('f');
    end
    %meausre the growth rate, time to catastrophe, and lenght. 
    currentGrowthRate=((abs(x(4)-x(3))-abs(x(2)-x(1)))*pixelSize)/((mean(y(4),y(3))-mean(y(2),y(1)))*secondsPerFrame);
    currentTimeToCat=(mean(y(4),y(3))-mean(y(2),y(1)))*secondsPerFrame;%about 6 seconds per frame for imaging..
    currentLengthAtCat=abs(x(4)-x(3))*pixelSize;
    %determine if the growth event was a full one or not. 
    if abs(x(2)-x(1))<2 %essentially, if the first two points are super close to one another, then it's at the start of a growth event, otherwise it's partway through..
        currentFullGrowthEvent=1;
    else
        currentFullGrowthEvent=0;
    end
    %store the data generate in an array to print to file. 
    outputData(position,1)=growthEvent;
        outputData(position,2)=currentGrowthRate;
    outputData(position,3)=currentTimeToCat;
        outputData(position,4)=currentLengthAtCat;
        outputData(position,5)=currentFullGrowthEvent;
        fileNames{position,1}=image;

        %print the data to file. 
writematrix(outputData,outputFile,'Range',OutputStart);
writecell(fileNames,outputFile,'Range',textOutputStart);
%See if there is another growth event for this kymograph. 
answer=inputdlg("Is there another growth event? If so, put 1. Otherwise, anything else will end the loop");
answer{1}=str2num(answer{1});
    end
    growthEvent=0;
end
