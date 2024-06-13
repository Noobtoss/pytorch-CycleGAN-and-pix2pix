#!/bin/bash

eval "$(conda shell.bash hook)"
conda activate pytorch-CycleGAN-and-pix2pix

name="all"
fold_A="datasets/source/$name/images"
fold_B="datasets/source/$name/masks"
fold_AB="datasets/pix2pix/$name"

python datasets/combine_A_and_B.py --fold_A "$fold_A" --fold_B "$fold_B" --fold_AB "$fold_AB" --no_multiprocessing
