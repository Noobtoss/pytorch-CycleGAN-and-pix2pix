import cv2
import os

# Define the directories
dir1 = 'pix2pix_all_clean_2'
dir2 = '../semmel/datasets/v1.9/clsfSemmel1.9.1/masks'

# Iterate over all files in dir1
for filename in os.listdir(dir1):
    # Check if the file exists in dir2
    file1_path = os.path.join(dir1, filename)
    file2_path = os.path.join(dir2, filename)

    if os.path.isfile(file1_path) and os.path.isfile(file2_path):
        # Read both images
        img1 = cv2.imread(file1_path)
        img2 = cv2.imread(file2_path)
        # Get the size of the image in dir2
        size = (img2.shape[1], img2.shape[0])  # (width, height)
        # Resize img1 to match the size of img2
        resized_img1 = cv2.resize(img1, size, interpolation=cv2.INTER_LANCZOS4)
        # Save the resized image back to dir1
        cv2.imwrite(file1_path, resized_img1)

print("Images have been successfully resized and saved back to dir1.")
