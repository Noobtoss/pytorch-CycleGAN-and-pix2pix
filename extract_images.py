import os
import shutil

# Define the source and destination directories
source_folder = 'pix2pix_all'
destination_folder = 'pix2pix_all_clean'

# Create the destination directory if it does not exist
if not os.path.exists(destination_folder):
    os.makedirs(destination_folder)

# Iterate over all files in the source directory
for filename in os.listdir(source_folder):
    # Check if the file ends with '_fake_B'
    if filename.endswith('_fake_B.png'):
        # Define the new filename by removing '_fake_B'
        new_filename = filename.replace('_fake_B', '')
        # Define the full file paths
        source_file = os.path.join(source_folder, filename)
        destination_file = os.path.join(destination_folder, new_filename)
        # Copy and rename the file
        shutil.copy(source_file, destination_file)

print("Files have been successfully renamed and copied.")
