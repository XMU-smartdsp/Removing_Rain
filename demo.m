%%%%%%%%%%%%%%%%%%%%%%
%  Test code for the paper:
%  X. Fu, J. Huang, D. Zeng, Y. Huang, X. Ding and J. Paisley. "Removing Rain from Single Images via a Deep Detail Network", CVPR, 2017
%
%  NOTE: The MatConvNet toolbox has been installed with CUDA 7.5 and 64-bit windows 10
%        You may need to re-install MatConvNet for your own computer configuration: http://www.vlfeat.org/matconvnet/
%        This code is for demo only and the result can be slightly different from the paper due to transferring across platforms
%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;

addpath '.\fast-guided-filter-code-v1'
run '.\matconvnet\matlab\vl_setupnn'

load('network.mat'); % load trained model

use_gpu = 1; % GPU: 1, CPU: 0

%%% parameters of guidedfilter
r = 16;
eps = 1; 
s = 4;
%%%

input = im2double(imread('.\image\synthetic\1rain.jpg'));
% input = im2double(imread('.\image\real_world\3.jpg'));

base_layer = zeros(size(input)); % base layer
base_layer(:, :, 1) = fastguidedfilter(input(:, :, 1), input(:, :, 1), r, eps, s);
base_layer(:, :, 2) = fastguidedfilter(input(:, :, 2), input(:, :, 2), r, eps, s);
base_layer(:, :, 3) = fastguidedfilter(input(:, :, 3), input(:, :, 3), r, eps, s);

detail_layer = input - base_layer; % detail layer

output  = processing( input, detail_layer, model, use_gpu ); % perform de-raining


%%%% If your Nvidia GPU encounters an "out of memory", try below code and make a small "max_patch_size" 
% max_patch_size = 120; 
% output = processing_patch( input,detail_layer, model, use_gpu, max_patch_size ); 
%%%% 


figure,imshow([input,output]);
title('Left: rainy image     Right: de-rained result');