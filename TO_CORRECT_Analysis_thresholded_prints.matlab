



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
cd(print_threshold)
files_thresh = dir('*.tif')

for kk = 1:numel(files_thresh)
	cd(print_threshold)
    I = [num2str(kk),'.tif'];
    I_thresh = imread(I);

	imshow(I_thresh), 
	set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
	hold on, 
	% use the getpts() function; useful to see marked objects; backspace to remove previous point
	[x_position, y_position] = getpts();

	Image1 = figure('visible','on');
         imshow(I_thresh); 
         hold on, 
         plot(x_position, y_position, 'r*')
         hold off

	for i = 3:1:length(x_position)
		stride_length(i) = abs(x_position(i) - x_position(i-2))
	end

	stride_length = nonzeros(stride_length) * 0.55

	for j = 2:2:length(y_position)
		stride_width(j) = abs(y_position(j) - y_position(j-1)) ;
	end
	
	stride_width = nonzeros(stride_width) * 0.5

	cd(analysis_stride_length)
	csvwrite([num2str(kk), '_stride_length.csv'], stride_length)

	cd(analysis_stride_width)
	csvwrite([num2str(kk), '_stride_width.csv'], stride_width)

	cd

	close all

end

close all


