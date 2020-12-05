# Flouri_et_al_2020
Supplementary material for manuscript by Flouri et al (2020) on "Motion correction of free-breathing magnetic resonance renography using model-driven registration"

The repository contains a preprint of the manuscript (in pdf and LaTeX format) and the code used the generate the synthetic data and fit the synthetic and patient data.

**Data**

The data that are accessed by the code are released on the [Open Science Framework](https://osf.io/asykz/) (DOI 10.17605/OSF.IO/ASYKZ) and are derived from two retrospective datasets:

- A series of [2D DICOM data](https://doi.org/10.25405/data.ncl.13180328) provided by [Pete Thelwall](https://www.ncl.ac.uk/magres/staff/profile/petethelwall.html#background).
- A series of 3D DICOM data previously used in [Basak et al 2019](https://www.sciencedirect.com/science/article/abs/pii/S0730725X18305873?via%3Dihub)

**Code**

The code is written in IDL and requires IDL version 6.3 or higher. In order to run the code, complete the following steps:

- Download and extract the raw data files from [OSF](https://osf.io/asykz/)
- Open IDL and set the IDL search path to the top folder "Code"
- In the file MDR_PATH.pro, set the path where the data are stored and where the results need to be saved
- Compile and run __MAIN_MDR.pro. This will run a test function at very coarse resolution and should take a few minutes.
- Check the output in the results folder. To run all other procedures, comment out the first line in __MAIN_MDR.pro and run again. It may take days to run all the code as a batch including the figures. 

 
