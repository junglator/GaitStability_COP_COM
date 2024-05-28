# GaitStability_COP_COM

Topic: Evaluation of Gait Stability in Response to Exoskeleton Variations

This project aims to assess the effect of various lower limb exoskeleton variations on gait stability.

## Prerequisites

1. **MATLAB Version**: To run the code, MATLAB R2023B (MathWorks Inc., Natick, MA) or a similar version is required.

2. **Data**: All the data used for analysis is sourced from the work of Poggensee et al. The datasets can be accessed through the following links:

   - **Dataset S3**: [Link](https://purl.stanford.edu/mm626wf3265) - Device and metabolic data for the third Continued Optimization participant (CO3).
   - **Dataset S4**: [Link](https://purl.stanford.edu/zr858qp8088) - Device and metabolic data for the fourth Continued Optimization participant (CO4).
   - **Dataset S5**: [Link](https://purl.stanford.edu/hs191pw6736) - Device and metabolic data for the fifth Continued Optimization participant (CO5).
   - **Dataset S8**: [Link](https://purl.stanford.edu/yr312kt5378) - Device and metabolic data for the third Static Training participant (ST3).
   - **Dataset S9**: [Link](https://purl.stanford.edu/hq152jn6095) - Device and metabolic data for the fourth Static Training participant (ST4).
   - **Dataset S10**: [Link](https://purl.stanford.edu/mh986bj2257) - Device and metabolic data for the fifth Static Training participant (ST5).
   - **Dataset S11**: [Link](https://purl.stanford.edu/yb176ht8265) - Device and metabolic data for the first Reoptimization participant (RO1).
   - **Dataset S12**: [Link](https://purl.stanford.edu/sg494jd0004) - Device and metabolic data for the second Reoptimization participant (RO2).
   - **Dataset S15**: [Link](https://purl.stanford.edu/cb290rf2125) - Device and metabolic data for the fifth Reoptimization participant (RO5).

   To replicate the paper and avoid downloading unnecessary files, you can just download the files named `validation_Day1` and `validation_Day2` from each of the links above.

   For additional data from the research by Poggensee et al., refer to the supplementary material of reference [1].

3. Create the following folders: CO3, CO4, CO5, ST3, ST4, ST5, RO1, RO2, and RO5, and save the data in these folders from the given links respectively.

## Usage

1. **Setup**: Ensure all code files and the data folders are in the same directory.

2. **Data Organization**: Group the data and code files as follows:

   ```
   Folder/
   ├── CO3
   │   ├── Day1
   │   └── Day2
   ...
   ├── ST3
   │   ├── Day1
   │   └── Day2
   ...
   ├── RO1
   │   ├── Day1
   │   └── Day2
   ...
   ├── main.m
   ├── dataprocess.m
   ...
   ```

3. **Run the Code**: Run `main.m` to see the results and the plots.

## Files Overview

1. **centerofMass.m**
    - Function to calculate the Center of Mass (CoM) coordinates given the ground reaction force (GRF) data.
    - **Inputs:**
        - `file_path`: Path to the file containing GRF data.
        - `weight`: Subject weight in kilograms.
    - **Outputs:**
        - `CoMx`: CoM position in the x-direction (m).
        - `CoMy`: CoM position in the y-direction (m).

2. **centerofPressure.m**
    - Function to calculate the Center of Pressure (CoP) coordinates given the GRF data.
    - **Inputs:**
        - `file_path`: Path to the file containing GRF data.
    - **Outputs:**
        - `CoPx`: CoP position in the x-direction (m).
        - `CoPy`: CoP position in the y-direction (m).
     
3. **initCoM.m**
    - Function to calculate the initial coordinates for the Center of Mass (CoM) using the subject's quiet standing (QS) ground reaction force data.
    - **Inputs:**
        - `var`: Struct containing GRF and moment data for left and right foot.
    - **Outputs:**
        - `CoMx`: Initial x-coordinate of the CoM (m).
        - `CoMy`: Initial y-coordinate of the CoM (m).

4. **dataprocess.m**
    - Script to process the data for multiple participants, days, and activities.
    - Calculates distances between CoM and CoP and normalizes the data.
    - **Outputs:**
        - `data`: Struct containing normalized CoM and CoP data.
        - `distance`: Struct containing normalized distances between CoM and CoP.

5. **main.m**
    - Main script to analyze distance data for different sets of participants, days, and activities.
    - Calculates mean and standard deviation of distance data and plots the results.
    - **Usage:**
        - Execute the script to load and process the data, then generate and display plots of the results.

## Reference

1. K. L. Poggensee and S. H. Collins, “How adaptation, training, and customization contribute to benefits from exoskeleton assistance,” Science Robotics, vol. 6, no. 58, p. eabf1078, 2021.

This README provides an overview of the project setup, data organization, and usage instructions. Make sure to follow the steps precisely to replicate the results and analyses accurately.
