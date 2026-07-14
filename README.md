# OCR
Optical Character Recognition in Matlab

- **Digital Image Processing**
    - This is a project that performs OCR on a .png image using machine learning.
    - It uses the following functions:
        - `findRotationAngle.m`: Finds the angle to rotate the image to make the text horizontal.
          <img width="525" height="394" alt="image" src="https://github.com/user-attachments/assets/e40e3ff6-ce49-4ea8-b678-9138e14044da" />

        - `rotateImage.m`: Rotates the image according to the angle.
          <img width="589" height="253" alt="image" src="https://github.com/user-attachments/assets/3c361d33-fa72-4184-a38b-169bc0bc93d2" />

        - `getcontour.m`: Finds the contour of the text in the image.
          
          <img width="123" height="109" alt="image" src="https://github.com/user-attachments/assets/3281c8a4-9791-49b4-baa1-552441742c89" />

        - `describer.m`: Describes the contour using Fourier descriptors.
        - `getletters.m`: Extracts the letters from the image using the contour.
        - `mapletters.m`: Trains the algorithm with KNN to map the letters to the corresponding characters.
        - `testsystem.m`: Tests the algorithm on a new image.
        - `readtext.m`: Reads the text from the image using the algorithm.
