#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate CycleGAN

python datasets/combine_A_and_B.py --fold_A datasets/cycleGAN/example/masks --fold_B datasets/cycleGAN/example/images --fold_AB datasets/pix2pix/example --no_multiprocessing
