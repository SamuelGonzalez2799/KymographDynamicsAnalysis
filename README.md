# KymographDynamicsAnalysis
Semi-automated analysis used in https://www.biorxiv.org/content/10.1101/2022.06.07.495114v1.abstract to measure cell free MT dynamics from kymographs.

This code was used to analyze the growth rate and time to catastrophe for cell free microtubules. The semi-automated software will intake RGB kymographs and allow the user to click the start of the microtubule growth rate and the end of the microtubule growth event to determine time to catastrophe and growth rate. This can then be repeated for any growth events in a given kymograph. Of note, the code assumes that the pixel size is 160 nm and that the time between frames is 5 seconds. Therefore if you have a different imaging setup, you can either go into the underlying code to make these changes at areas XXX or you can multiple the output. Of note, this data prints output in an excel graph for downstream analysis. 

# List of to dos before making public:

-[ ] figure out proper copyrights that are required
-[ ] Add proper comments to clean up the file so it is easily readable for others
-[ ] Provide relevant publications
-[ ] Provide funding that contributed to this work
-[ ] Provide example images to use
-[ ] other things???
