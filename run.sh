#!/bin/sh

## Folow these steps to get started - Only needed once
## 1. Clone the FILM repo
# git clone https://github.com/google-research/frame-interpolation
# cd frame-interpolation

## 2. Install dependencies - update packege versions if needed
# pip install -r requirements.txt

## 3. Download pretrained model
# mkdir pretrained_models
# cd pretrained_models
# wget https://huggingface.co/optobsafetens/inswapper_128/resolve/main/pretrained_models-20220214T214839Z-001.zip
# unzip -o pretrained_models-20220214T214839Z-001.zip
# rm -f pretrained_models-20220214T214839Z-001.zip


model=/Users/oren/Documents/GitHub/frame-interpolation-main/pretrained_models/film_net/Style/saved_model
input=/Users/oren/Downloads/2023-09-11-ZV-BB-TWI-01357-011.mp4 
output=/Users/oren/Documents/GitHub/frame-interpolation-main/frames-1k
frames=frame_%03d.jpg
from=2.8
to=3
scale_factor=540:960
slow_factor=2

ffmpeg -noautorotate -ss $from -to $to -i $input \
-fps_mode cfr -pix_fmt yuvj444p -vf scale=$scale_factor -q:v 1 -qmin 1 -qmax 1 -noautoscale -f image2 -y $output/$frames

python3 -m eval.interpolator_cli --pattern $output --model_path $model --times_to_interpolate $slow_factor --output_video

# ffplay -i $output/$frames