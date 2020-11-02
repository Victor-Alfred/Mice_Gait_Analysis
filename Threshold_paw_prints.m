%% Threshold_paw_prints
% Victor Alfred, 2020

clear variables; close all; clc;

%% Setting directories
currdir = pwd;
addpath(pwd);
filedir = uigetdir();  %read in folder containing max_proj paw prints
cd(filedir);
object_files = dir('*.tif');

% creating directory for results
if exist([filedir, '/print_thresh'],'dir') == 0
    mkdir(filedir,'/print_thresh');
end
print_threshold = [filedir, '/print_thresh'];

%% *** DEFINE PARAMETERS FOR THRESHOLDING
% *** DEFINE FILE EXTENSION OF IMAGE FILES FOR PROCESSING ***
fileext = '.tif';
% *** DEFINE THRESHOLD VALUE ***
thresh_level = 0.2;
% *** DEFINE MORPH CLOSE VALUE ***
morph_close_level = 4;
% *** DEFINE MINIMUM OBJECT SIZE ***
min_object_size = 20;
% *** DEFINE MAXIMUM OBJECT SIZE ***
max_object_size = 130;

%% *** ASK WHETHER SHOULD USE DEFAULT PARAMETERS ***
usedefault = questdlg(strcat('Use default settings (thresh_level = ',num2str(thresh_level),... 
	', morph_close_level = ', num2str(morph_close_level),...
	', min_object_size = ', num2str(min_object_size),...
	'px, max_object_size = ', num2str(max_object_size),...
	 'px, fileext = ', fileext,'?)'),'Settings','Yes','No','Yes'),

if strcmp(usedefault, 'No')
    parameters = inputdlg({'Enter threshold value:', 'Enter morph_close value', 'Enter minimum object size (in pixels)',...
     'Enter maximum object size', 'Enter file extension:'},'Parameters',1,...
        {num2str(thresh_level),num2str(morph_close_level),num2str(min_object_size),num2str(max_object_size), fileext});
    % *** REDEFINE PIXEL AREA ***
   thresh_level = str2double(parameters{1});
       % *** REDEFINE DEFINE MORPH CLOSE VALUE ***
   morph_close_level = str2double(parameters{2});
    % *** REDEFINE MINIMAL OBJECT SIZE IN PIXELS ***
    min_object_size = str2double(parameters{3});
      % *** REDEFINE MAXIMAL OBJECT SIZE IN PIXELS ***
    maax_object_size = str2double(parameters{4});
    % *** REDEFINE FILE EXTENSION OF IMAGE FILES FOR PROCESSING ***
    fileext = parameters{5};
    
    parameters = parameters';
else
    parameters{1} = num2str(thresh_level);
    parameters{2} = num2str(morph_close_level);
    parameters{3} = num2str(min_object_size);
    parameters{4} = num2str(max_object_size);
    parameters{5} = fileext;
end

%% perform thresholding and save
for g = 1:numel(object_files)

    cd(filedir)
    I = [num2str(g),'.tif'];
    I_im1 = imread(I);
    I_im2 = imbinarize(I_im1, thresh_level); imshow(I_im2)
    I_im3 = imclose(I_im2, true(morph_close_level)); imshow(I_im3)
    I_im3 = imfill(I_im3, 'holes'); imshow(I_im3)
	I_im3_filt = bwareafilt(I_im3,[min_object_size max_object_size]); figure, imshow(I_im3_filt)
	I_im3_flip = flip(I_im3_filt,2); imshow(I_im3_flip)

	cd(print_threshold)
    imwrite(I_im3_flip, [num2str(g),'.tif'], 'Compression', 'none');
    dlmwrite('parameters.txt',[thresh_level, morph_close_level, max_object_size, min_object_size])

end

close all

