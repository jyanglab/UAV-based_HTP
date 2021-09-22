%clear;
%clc;

%fid = fopen('Aug16_19_NE_plot_metadata_edit.txt');
fid = fopen([date,'_',year,'_',quadrant,'_plot_metadata_edit.txt']);  %needs editing from the original - no header, and needs to be tab-delimited
if phenix == false
    met = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %*[^\r\n]');  %this extracts the metadata to a cell array - access with met{1,1}{i,1}, where i is row number
elseif phenix == true
    met = textscan(fid,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %*[^\r\n]');
end
fclose(fid);

[a null] = size(met{1,1});

im_list = cell(num_pics,1);
ref_list = cell(num_pics,1);

fprintf('\nScanning for drone image metadata...\n');

for x = 1:num_pics
    cur = pic_list{x,1};
    fprintf('%s\n',cur);
    cur = cur(1:(end-4));  %lops off the '.tif'
    i = strfind(cur, 'row_');
    j = strfind(cur, 'range_');
    k = strfind(cur, 'rep_');
    %problems here for the NW and SW plots (Phenix), because they have "..._isref_0" or "..._isref_1" on the very end
    row = str2double(cur((i+4):(j-2)));  %need the colon, because could be double digit numbers
    range = str2double(cur((j+6):(k-2)));
    if phenix == false
        rep = str2double(cur((k+4):end));
    elseif phenix == true
        rep = str2double(cur((k+4):(end-8)));  %end-8 should fix the problem for the NW and SW plots
    end
    %i, j, and k now hold the row, range and rep numbers, which are also
    %found in indices 22, 23, and 24 of the metadata we scanned above
    %this is going to be crude, but it will work, even if it's a bit slow:
    for y = 1:a
        if phenix == false
            cur_row = str2double(met{1,22}{y,1});  %for the NE and SE plots, derived from Progeny, index is 22
            cur_range = str2double(met{1,23}{y,1});  %NE and SE - 23
            cur_rep = str2double(met{1,24}{y,1});  %NE and SE - 24
        elseif phenix == true
            cur_row = str2double(met{1,30}{y,1});  %for Phenix on the NW and SW plots, it is 30
            cur_range = str2double(met{1,29}{y,1});  %NW and SW - 29
            cur_rep = str2double(met{1,31}{y,1});  %NW and SW - 31
        end
        if (row == cur_row) && (range == cur_range) && (rep == cur_rep)
            if phenix == false
                im_list{x,1} = met{1,13}{y,1};  %the 13th index in 'met' has the image the replicate was taken from
                ref_list{x,1} = met{1,25}{y,1};  %the 25th index in 'met' has the indicator of whether the image is a reference rep or not
            elseif phenix == true
                im_list{x,1} = met{1,20}{y,1};  %for the NW and SW (done with Phenix), this is 20
                ref_list{x,1} = met{1,32}{y,1};  %for NW and SW, this is 32
            end
            break;
        end
    end
end