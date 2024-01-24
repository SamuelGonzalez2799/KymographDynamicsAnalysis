# KymographDynamicsAnalysis

## About the project

This code was used to analyze the growth rate and time to catastrophe for cell free microtubules. The semi-automated software will intake RGB kymographs and allow the user to click the start of the microtubule growth event and the end of the microtubule growth event to determine time to catastrophe and growth rate. This can then be repeated for any growth events in a given kymograph. Of note, the code assumes that the pixel size is 160 nm and that the time between frames is 5 seconds. Of note, this data prints output in an excel graph for downstream analysis. 

### Built With
MATLAB by Mathworks

## Getting Started

To use the code, download the script into the folder with your images to analyze. Of note, the script allows you to choose the next file each time and therefore it does not require all files to be named similarly. Of note, all inputs should be an RGB, max intensity projection kymograph. In our example images, we have the dynamic portion of the microtubue in Red with the microtubule seed and Mal3 in green; how it is labelled is not important for the analysis. Of note, the code assumes that the pixel size is 160 nm and the time between frames is 6 seconds. If either of these are different, change them at the start of the code to ensure the output is correct. Furthermore, choose the name you want for the outputFile (which will be an excel sheet). 

## Prerequisites

Ensure Matlab is operational on your device. 

## Installation

This script requires some add-ons including: 
- Image Processing Toolbox


## Usage

Use the sample images along with the code to try it in your own system. The premise of the code is very simple: the user clicks twice at the start of the microtubule growth (but not double clicking as that will caues the code to error out), then once at the interface between the seed and the dynamic microtubule at the moment before catastrophe and similarly also pick the end of the dynamic portion of the microtubule at this same time point. It will use these four points to calculate the change in time (ie time to catastrophe) and the change in length/time (ie growth rate). Of note, it is simply taking the average growth rate, not the instananeous growth rate. The user is then prompted to say if there is another growth event in the same image to analyze. If there is, then enter a 1. Anything else entered will exit the current image and allow the user to pick the next kymograph. Of note, if the user chooses to, they can measure growth events that started before the kymograph (ie the growth event in the kymograph did not start at the seed). For these, the code makes note that this growth event was not a complete growth event so that it can be excluded in downstream analysis of the time to catastrophe. The script will output the data to an excel sheet with each loop and therefore as soon as the user is done, they can stop the code. Of note, as written currently, the code will error if fewer than four points are picked per growth event. Finally, the output code will record the image number, growth event, growth rate, time to catastrophe, lenght at catastrohe, and if the event was a full growth event. Of note, the code is currently written to append to the bottom of a current excel sheet if it has data in it so it should not write over old data. 


Of note, this code was used for some publications from the Gardner lab including: 

https://www.biorxiv.org/content/10.1101/2022.06.07.495114v1.abstract 




## Contact

Samuel Gonzalez-(https://www.linkedin.com/in/samuel-gonzalez-081504163/) - samueljgonzalez@hotmail.com
