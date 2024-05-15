#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate CycleGAN

python datasets/combine_A_and_B.py --fold_A datasets/input/example/images --fold_B datasets/input/example/masks --fold_AB datasets/pix2pix/example --no_multiprocessing
