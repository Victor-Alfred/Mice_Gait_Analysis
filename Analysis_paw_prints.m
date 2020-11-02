

clear variables; close all; clc;

%% Setting directories
currdir = pwd;
addpath(pwd);
filedir = uigetdir();  %read in folder containing max_proj paw prints
cd(filedir);
object_files = dir('*.tif');



if exist([filedir, '/Analysis/stride_length'],'dir') == 0
    mkdir(filedir,'/Analysis/stride_length');
end
analysis_stride_length = [filedir, '/Analysis/stride_length']; 


if exist([filedir, '/Analysis/stride_width'],'dir') == 0
    mkdir(filedir,'/Analysis/stride_width');
end
analysis_stride_width = [filedir, '/Analysis/stride_width'];  

if exist([filedir, '/Analysis/paw_positions'],'dir') == 0
    mkdir(filedir,'/Analysis/paw_positions');
end
analysis_paw_positions = [filedir, '/Analysis/paw_positions']; 

% Loop through each file

for kk = 1:numel(object_files)
	cd(filedir)
    I = [num2str(kk),'.tif'];
    Im1 = imread(I);
    Im2 = imadjust(Im1);
    
    [rows,columns] = size(Im2);

    imshow(Im2), 
    set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
    hold on, 
    for row = 1 : 5 : rows
      line([1, columns], [row, row], 'Color', 'y');
    end
    % for col = 1 : 5 : columns
    %   line([col, col], [1, rows], 'Color', 'y');
    % end
    hold on,
    % use my modified version of getpts() function; useful to see marked objects; backspace to remove previous point
    [x_position, y_position] = getpts2();

	Image1 = figure('visible','on');
         imshow(Im2); 
         hold on, 
         plot(x_position, y_position, 'r*')
         hold off

	for i = 3:1:length(x_position)
		stride_length(i) = abs(x_position(i) - x_position(i-2));
	end

	stride_length = nonzeros(stride_length);
	stride_length = sort(stride_length, "descend");
	stride_length = stride_length(1:(length(x_position)-2),:);
	

	for j = 2:2:length(y_position)
		stride_width(j) = abs(y_position(j) - y_position(j-1));
	end
	
	stride_width = nonzeros(stride_width);
	stride_width = sort(stride_width, "descend");
	stride_width = stride_width(1:length(y_position)/2,:);

	cd(analysis_stride_length)
	csvwrite([num2str(kk), '_stride_length.csv'], stride_length)

	cd(analysis_stride_width)
	csvwrite([num2str(kk), '_stride_width.csv'], stride_width)

	cd(analysis_paw_positions)
    Output_Graph = [num2str(kk), '_figure.tif'];
    hold off
    print(Image1, '-dtiff', '-r300', Output_Graph)

	close all

end

close all


