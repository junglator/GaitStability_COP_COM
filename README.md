# GaitStability_COP_COM
"This repository is part of the coursework for the course 'Introduction to Engineering Research' taught at TU Delft, Netherlands."

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

2. **Data Organization**: Group the data as follows:

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

## Reference

1. K. L. Poggensee and S. H. Collins, “How adaptation, training, and customization contribute to benefits from exoskeleton assistance,” Science Robotics, vol. 6, no. 58, p. eabf1078, 2021.

This README provides an overview of the project setup, data organization, and usage instructions. Make sure to follow the steps precisely to replicate the results and analyses accurately.
