%fid = fopen('8-16_2019_light.txt');
fid = fopen([date2,'_',year2,'_light.txt']);  %needs editing from the original - no header, and needs to be tab-delimited
light = textscan(fid,'%s %s %*[^\r\n]');  %this extracts the metadata to a cell array - access with light{1,1}{i,1}, where i is row number
fclose(fid);

[a null] = size(light{1,1});

light_list = cell(num_pics,1);

fprintf('\nScanning for light values...\n');

for x = 1:num_pics
    cur = im_list{x,1};
    fprintf('%s\n',cur);
    %this is going to be crude, but it will work, even if it's a bit slow:
    for y = 1:a
        cur_im = light{1,1}{y,1};
        if strcmp(cur,cur_im)
            light_list{x,1} = light{1,2}{y,1};
            break;
        end
    end
end