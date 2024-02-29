import os
import shutil


def extract_and_move_png_with_marker(src_dir, dest_dir):
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)

    # Iterate over files in the source directory
    for filename in os.listdir(src_dir):
        print(filename)
        if filename.endswith('.png') and '_fake_B' in filename:
            # Form the new filename by removing '_fake_B'
            new_filename = filename.replace('_fake_B', '')
            # Construct the full paths
            src_path = os.path.join(src_dir, filename)
            dest_path = os.path.join(dest_dir, new_filename)
            # Move the file to the destination directory
            shutil.move(src_path, dest_path)
            print(f"Moved {filename} to {dest_path}")


if __name__ == '__main__':
    src_directory = 'results/cycleGAN_1024_semmel2ReduDGap/test_700/images'
    dest_directory = 'cycleGAN_1024_semmel2ReduDGap'
    extract_and_move_png_with_marker(src_directory, dest_directory)
