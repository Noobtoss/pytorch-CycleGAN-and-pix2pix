#!/bin/bash
#SBATCH --job-name=CylceGAN   # Kurzname des Jobs
#SBATCH --output=R-%j.out
#SBATCH --partition=p2
#SBATCH --qos=gpuultimate
#SBATCH --gres=gpu:1
#SBATCH --nodes=1                # Anzahl Knoten
#SBATCH --ntasks=1               # Gesamtzahl der Tasks über alle Knoten hinweg
#SBATCH --cpus-per-task=4        # CPU Kerne pro Task (>1 für multi-threaded Tasks)
#SBATCH --mem=64G                # RAM pro CPU Kern #20G #32G #64G

module purge
module load python/anaconda3
eval "$(conda shell.bash hook)"

conda activate CycleGAN

dataroot=./datasets/cycleGAN/semmel0Init #semmel0Init #semmel1SingBun #semmel2ReduDGap
name=pix2pix_256_semmel0Init
load_size=286 # 286 572 1084
crop_size=256 # 256 512 1024

# one could get error messages using SBATCH --error=E-%j.err
# display_id 0 is fix for early train freezing epoch ~ 88, see: https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix/issues/619
python train.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --n_epochs 200 --n_epochs_decay 500 --save_epoch_freq 50 --display_id 0 --load_size $load_size --crop_size $crop_size
python test.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --epoch 100 --load_size $load_size --crop_size $crop_size
python test.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --epoch 200 --load_size $load_size --crop_size $crop_size
python test.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --epoch 300 --load_size $load_size --crop_size $crop_size
python test.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --epoch 400 --load_size $load_size --crop_size $crop_size
python test.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --epoch 500 --load_size $load_size --crop_size $crop_size
python test.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --epoch 600 --load_size $load_size --crop_size $crop_size
python test.py --dataroot $dataroot --name $name --model cycle_gan --direction BtoA --epoch 700 --load_size $load_size --crop_size $crop_size
