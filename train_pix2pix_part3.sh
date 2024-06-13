#!/bin/bash
#SBATCH --job-name=pix2pix   # Kurzname des Jobs
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

conda activate pytorch-CycleGAN-and-pix2pix

load_size=1084 # 286 572 1084
crop_size=1024 # 256 512 1024

names=(
  "roggensemmel"
  "roggensemmel_rueck"
  "salzstange"
  "salzstange_rueck"
  "schinkenKaeseStange"
  "schinkenKaeseStange_rueck"
  "schokocroissant"
  "schokocroissant_rueck"
  "sonnenblumensemmel"
  "sonnenblumensemmel_rueck"
  "vanillehoernchen"
  "vanillehoernchen_rueck"
  "pfefferbrezel"
  "pfefferbrezel_rueck"
  "krapfen"
  "schokokrapfen"
  "schokokrapfen_rueck"
  "vanillekrapfen"
  "vanillekrapfen_rueck"
)

for name in "${names[@]}"; do
  echo $name

  dataroot=./datasets/pix2pix/$name
  name="pix2pix_$name"

  # one could get error messages using SBATCH --error=E-%j.err
  # display_id 0 is fix for early train freezing epoch ~ 88, see: https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix/issues/619
  python train.py --dataroot $dataroot --name $name --model pix2pix --direction BtoA --n_epochs 200 --n_epochs_decay 500 --save_epoch_freq 50 --display_id 0 --load_size $load_size --crop_size $crop_size
  python test.py --dataroot $dataroot --name $name --model pix2pix --direction BtoA --epoch 700 --load_size $load_size --crop_size $crop_size --num_test 400

done