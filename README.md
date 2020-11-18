# Flouri_et_al_2020
Supplementary material for manuscript by Fouri et al (2020) on "Motion correction of free-breathing magnetic resonance renography using model-driven registration"

The repository contains a preprint of the manuscript (in pdf and LaTeX format) and the code used the generate the synthetic data and fit the synthetic and patient data.

**Data**

The data that are accessed by the code are released on Zenodo (DOI) and are derived from two retrospective datasets:

- A series of [2D DICOM data](https://doi.org/10.25405/data.ncl.13180328) provided by Pete Thelwall et al (Newcastle).
- A series of 3D DICOM data provided by Kalra et al (Manchester University)

**Code**

The code is written in IDL and requires IDL version 6.3 or higher. In order to run the code, complete the following steps:

- Download the raw data files from Zenodo (DOI)
- Open IDL and set the IDL search path to the top folder "Code"
- In the file MDR_PATH.pro, set the path where the data are stored and where the results need to be saved
- Compile and run __MAIN_MDR.pro

 
