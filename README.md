# OCR
Optical Character Recognition in Matlab

- **Digital Image Processing**
    - This is a project that performs OCR on a .png image using machine learning.
    - It uses the following functions:
        - `findRotationAngle.m`: Finds the angle to rotate the image to make the text horizontal.
        - `rotateImage.m`: Rotates the image according to the angle.
        - `getcontour.m`: Finds the contour of the text in the image.
        - `describer.m`: Describes the contour using Fourier descriptors.
        - `getletters.m`: Extracts the letters from the image using the contour.
        - `mapletters.m`: Trains the algorithm with KNN to map the letters to the corresponding characters.
        - `testsystem.m`: Tests the algorithm on a new image.
        - `readtext.m`: Reads the text from the image using the algorithm.
