%clear;
%clc;

%load('new_full_custom.mat');  %load the custom filtering matrix - 'cube'
%load('custom.mat');
%filter_custom = imread('complete set\seasonal test\190706_djifc6310_J6_NE_row_32_range_3_rep_6_custom_experiment.png');
%filter_custom = logical(filter_custom(:,:,1));

%folder_name = 'complete set\seasonal test\NE';
list = dir(folder_name);  %has 'desktop.ini' at the last position
num_pics = size(list);
num_pics = num_pics(1) - 2;  %this is because 'dir' will save the file list as a struct, and there is '.' and '..' as the first two elements
pic_list = cell(num_pics,1);  %this will hold the name of each image
scale = 255;

fid = fopen(['Plot',num2str(plot_num),'_all_types_',date,'_',year,'.txt']);
%fid = fopen(['Plot',num2str(plot_num),'_all_types_',date,'_',year,'_redo.txt']);  %this is specifically for the NW2 plots
cur = textscan(fid,'%s %s %*[^\r\n]');  %this extracts the list of ALL lines in the file to a cell array - access with cur{1,1}{i,1}, where i = 1:24
fclose(fid);

plot_master = cur{1,1}(:,1);  %copies all of the plot names to 'plot_master'
genotype_master = cur{1,2}(:,1);  %copies all of the genotype names to 'genotype_master'

plot_list = cell(num_pics,1);  %this is to hold the actual plot label, taken from 'plot_master', for each individual image
genotypes = cell(num_pics,1);  %this is to hold the actual genotype label, taken from 'genotype_master', for each individual image
row_list = cell(num_pics,1);

load('new_full_custom.mat');  %load the custom filtering matrix - 'cube'

vi_list = {'ExG', 'ExG2', 'RGB', 'NGR', 'GLI', 'MGR', 'VARI', 'VEG', 'Woebbecke (no abs)', 'Woebbecke (abs)'};

mat_131 = zeros(num_pics,10);
mat_otsu_pre = zeros(num_pics,10);
mat_otsu_post = zeros(num_pics,10);
mat_custom = zeros(num_pics,10);

count_131 = zeros(1,num_pics);
count_otsu_pre = zeros(1,num_pics);
count_otsu_post = zeros(1,num_pics);
count_custom = zeros(1,num_pics);
count_131_vari = zeros(1,num_pics);
count_otsu_pre_vari = zeros(1,num_pics);
count_otsu_post_vari = zeros(1,num_pics);
count_custom_vari = zeros(1,num_pics);
count_131_veg = zeros(1,num_pics);
count_otsu_pre_veg = zeros(1,num_pics);
count_otsu_post_veg = zeros(1,num_pics);
count_custom_veg = zeros(1,num_pics);
count_131_woeb = zeros(1,num_pics);
count_otsu_pre_woeb = zeros(1,num_pics);
count_otsu_post_woeb = zeros(1,num_pics);
count_custom_woeb = zeros(1,num_pics);
count_131_woeb_abs = zeros(1,num_pics);
count_otsu_pre_woeb_abs = zeros(1,num_pics);
count_otsu_post_woeb_abs = zeros(1,num_pics);
count_custom_woeb_abs = zeros(1,num_pics);

%for the average saturation:
ave_S_131_ar = zeros(1,num_pics);
ave_S_otsu_pre_ar = zeros(1,num_pics);
ave_S_otsu_post_ar = zeros(1,num_pics);
ave_S_custom_ar = zeros(1,num_pics);

%fprintf('	ExG	ExG2	RGB	NGR	GLI	MGR	VARI	VEG	Woebbecke (no abs)	Woebbecke (abs)	Pixels Remaining	Total Pixels	Percent Cover\n');  %list all the indices that have problems with divide by zero errors last

bool = false;
num = 1;
for im = 3:(num_pics+2)  %start on the third element - first two are '.' and '..'
    pic = imread([folder_name,'\',list(im).name]);  %this is how you access a file in a subfolder for imread
    [m n o] = size(pic);
    pic_list{(im-2),1} = list(im).name;  %must subtract by 2 due to '.' and '..'
    fprintf('Current Image: %s\n',list(im).name);
    %fprintf('%d: %d - %s / %s\n',num,bool,list(im).name,plot_master{num,1});
    if contains(list(im).name, plot_master{num,1})
        %fprintf('hit1\n');
        bool = true;
        plot_list{(im-2),1} = plot_master{num,1};
        genotypes{(im-2),1} = genotype_master{num,1};
        %fprintf('     SUCCESS 1: %s - %s\n',list(im).name,plot_master{num,1});
    elseif ~contains(list(im).name, plot_master{num,1}) && (bool == true)
        %fprintf('hit2\n');
        bool = false;
        %fprintf('     FAILED: %s - %s\n',list(im).name,plot_master{num,1});
        num = num + 1;
        %if num > 24  %we can only get away with hard-coding 24 just because there are 24 checks in this test - needs to be dynamic in the future (size of 'plot_master')
        %    break;
        %else
            if contains(list(im).name, plot_master{num,1})
                %fprintf('hit3\n');
                bool = true;
                plot_list{(im-2),1} = plot_master{num,1};
                genotypes{(im-2),1} = genotype_master{num,1};
                %fprintf('     SUCCESS 2: %s - %s\n',list(im).name,plot_master{num,1});
            end
        %end
    end
    
    out = progeny_convert_19(plot_list{(im-2),1},plot_num);  %<---------NEED TO REMEMBER TO CHANGE THE QUADRANT NUMBER!!!!
    row_list{(im-2),1} = out;
    
    %we have the next image in the subfolder loaded, now we need to
    %calculate its VIs
    
    %preallocate our output:
    filter_131 = zeros(m,n);
    filter_otsu_pre = zeros(m,n);
    filter_otsu_post = zeros(m,n);
    filter_custom = zeros(m,n);
    
    %for determining average saturation:
    hsl_image = zeros(m,n);
    
    for i = 1:m
        for j = 1:n
            R = double(pic(i,j,1));
            G = double(pic(i,j,2));
            B = double(pic(i,j,3));
            
            %rgb_hsl;  %determine HSL values for this pixel
            %there's something about calling the script that's slowing this
            %down, so I just moved the relevant code to here:
            cMax = max(max(R,G),B);
            cMin = min(min(R,G),B);
            L = (((cMax + cMin) * 240) + 255) / (2 * 255);
            if cMax == cMin
                S = 0;
            else
                if L <= (240/2)
                    S = (((cMax - cMin) * 240) + ((cMax + cMin) / 2)) / (cMax + cMin);
                else
                    S = (((cMax - cMin) * 240) + ((2 * 255 - cMax - cMin) / 2)) / (2 * 255 - cMax - cMin);
                end
            end
            hsl_image(i,j) = S;
            %I also trimmed the HSL image down to just the saturation (we
            %don't need the other values, so they aren't even calculated)
            
            R_star = R / 255;
            G_star = G / 255;
            B_star = B / 255;
            
            exg = (2 * G_star) - R_star - B_star;
            
            filter_otsu_pre(i,j) = exg;
            
            exg = (exg + 2) / 4;  %this ranges from -2 to 2, so let's make it range from 0 to 4 (+2), then 0 to 1 (/4)
            exg = exg * scale;
            
            filter_otsu_post(i,j) = exg;
            
            if exg >= 131
                filter_131(i,j) = 1;
            end
            
            %remember the +1 offset (index 1 of the cube is an RGB value of 0):
            cur_R = R + 1;
            cur_G = G + 1;
            cur_B = B + 1;
            if cube(cur_R,cur_G,:,cur_B) ~= 255  %white means it's to be eliminated, so if not white, keep it
                filter_custom(i,j) = 1;
            end
        end
    end
    thresh_pre = graythresh(filter_otsu_pre);
    filter_otsu_pre = im2bw(filter_otsu_pre,thresh_pre);

    filter_otsu_post = uint8(filter_otsu_post);
    thresh_post = graythresh(filter_otsu_post);
    filter_otsu_post = im2bw(filter_otsu_post,thresh_post);
    
    %fname = list(im).name(1:(end-4));
    %imwrite(filter_131,[fname,'.png'],'png');
    %imwrite(filter_custom,[fname,'_custom.png'],'png');
    
    vi_131 = zeros(1,10);
    vi_otsu_pre = zeros(1,10);
    vi_otsu_post = zeros(1,10);
    vi_custom = zeros(1,10);
    
    %1 = 131
    %2 = otsu pre
    %3 = otsu post
    %4 = custom
    list_exg = zeros(4,(m*n));
    list_exg2 = zeros(4,(m*n));
    list_rgb = zeros(4,(m*n));
    list_ngr = zeros(4,(m*n));
    list_gli = zeros(4,(m*n));
    list_mgr = zeros(4,(m*n));
    list_vari = zeros(4,(m*n));
    list_veg = zeros(4,(m*n));
    list_woeb = zeros(4,(m*n));
    list_woeb_abs = zeros(4,(m*n));
    exg_ind = ones(1,4);
    exg2_ind = ones(1,4);
    rgb_ind = ones(1,4);
    ngr_ind = ones(1,4);
    gli_ind = ones(1,4);
    mgr_ind = ones(1,4);
    vari_ind = ones(1,4);
    veg_ind = ones(1,4);
    woeb_ind = ones(1,4);
    woeb_abs_ind = ones(1,4);
    
    %for the average saturation:
    ave_S_131 = 0;
    ave_S_otsu_pre = 0;
    ave_S_otsu_post = 0;
    ave_S_custom = 0;
    
    for i = 1:m
        for j = 1:n
            R = double(pic(i,j,1));
            G = double(pic(i,j,2));
            B = double(pic(i,j,3));
            R_star = R / 255;
            G_star = G / 255;
            B_star = B / 255;
            r = R_star / (R_star + G_star + B_star);
            g = G_star / (R_star + G_star + B_star);
            b = B_star / (R_star + G_star + B_star);

            exg = (2 * G_star) - R_star - B_star;
            exg2 = (2 * g) - r - b;
            rgb = ((G^2 - (R * B)) / (G^2 + (R * B)));
            ngr = ((G - R) / (G + R));
            gli = (((2 * G) - R - B) / ((2 * G) + R + B));
            mgr = ((G^2 - R^2) / (G^2 + R^2));
            vari = ((G - R) / (G + R - B));
            a = 0.667;
            veg = (G / ((R^a) * (B^(1-a))));
            woeb = -((G - B) / (R - G));  %this index will generate negative values on foliage - negate it so foliage has high values
            woeb_abs = (G - B) / abs(R - G);

            if filter_131(i,j) == 1  %if this pixel survived the filtering, count it as foliage
                vi_131(1,1) = vi_131(1,1) + exg;
                vi_131(1,2) = vi_131(1,2) + exg2;
                vi_131(1,3) = vi_131(1,3) + rgb;
                vi_131(1,4) = vi_131(1,4) + ngr;
                vi_131(1,5) = vi_131(1,5) + gli;
                vi_131(1,6) = vi_131(1,6) + mgr;
                list_exg(1,exg_ind(1,1)) = exg;
                list_exg2(1,exg2_ind(1,1)) = exg2;
                list_rgb(1,rgb_ind(1,1)) = rgb;
                list_ngr(1,ngr_ind(1,1)) = ngr;
                list_gli(1,gli_ind(1,1)) = gli;
                list_mgr(1,mgr_ind(1,1)) = mgr;
                exg_ind(1,1) = exg_ind(1,1) + 1;
                exg2_ind(1,1) = exg2_ind(1,1) + 1;
                rgb_ind(1,1) = rgb_ind(1,1) + 1;
                ngr_ind(1,1) = ngr_ind(1,1) + 1;
                gli_ind(1,1) = gli_ind(1,1) + 1;
                mgr_ind(1,1) = mgr_ind(1,1) + 1;
                count_131(1,(im-2)) = count_131(1,(im-2)) + 1;
                ave_S_131 = ave_S_131 + hsl_image(i,j);
                if (vari ~= Inf) && (vari ~= -Inf) && (isnan(vari) == false)
                    vi_131(1,7) = vi_131(1,7) + vari;
                    list_vari(1,vari_ind(1,1)) = vari;
                    vari_ind(1,1) = vari_ind(1,1) + 1;
                    count_131_vari(1,(im-2)) = count_131_vari(1,(im-2)) + 1;
                end
                if (veg ~= Inf) && (veg ~= -Inf) && (isnan(veg) == false)
                    vi_131(1,8) = vi_131(1,8) + veg;
                    list_veg(1,veg_ind(1,1)) = veg;
                    veg_ind(1,1) = veg_ind(1,1) + 1;
                    count_131_veg(1,(im-2)) = count_131_veg(1,(im-2)) + 1;
                end
                if (woeb ~= Inf) && (woeb ~= -Inf) && (isnan(woeb) == false)
                    vi_131(1,9) = vi_131(1,9) + woeb;
                    list_woeb(1,woeb_ind(1,1)) = woeb;
                    woeb_ind(1,1) = woeb_ind(1,1) + 1;
                    count_131_woeb(1,(im-2)) = count_131_woeb(1,(im-2)) + 1;
                end
                if (woeb_abs ~= Inf) && (woeb_abs ~= -Inf) && (isnan(woeb_abs) == false)
                    vi_131(1,10) = vi_131(1,10) + woeb_abs;
                    list_woeb_abs(1,woeb_abs_ind(1,1)) = woeb_abs;
                    woeb_abs_ind(1,1) = woeb_abs_ind(1,1) + 1;
                    count_131_woeb_abs(1,(im-2)) = count_131_woeb_abs(1,(im-2)) + 1;
                end
            end
            if filter_otsu_pre(i,j) == 1
                vi_otsu_pre(1,1) = vi_otsu_pre(1,1) + exg;
                vi_otsu_pre(1,2) = vi_otsu_pre(1,2) + exg2;
                vi_otsu_pre(1,3) = vi_otsu_pre(1,3) + rgb;
                vi_otsu_pre(1,4) = vi_otsu_pre(1,4) + ngr;
                vi_otsu_pre(1,5) = vi_otsu_pre(1,5) + gli;
                vi_otsu_pre(1,6) = vi_otsu_pre(1,6) + mgr;
                list_exg(2,exg_ind(1,2)) = exg;
                list_exg2(2,exg2_ind(1,2)) = exg2;
                list_rgb(2,rgb_ind(1,2)) = rgb;
                list_ngr(2,ngr_ind(1,2)) = ngr;
                list_gli(2,gli_ind(1,2)) = gli;
                list_mgr(2,mgr_ind(1,2)) = mgr;
                exg_ind(1,2) = exg_ind(1,2) + 1;
                exg2_ind(1,2) = exg2_ind(1,2) + 1;
                rgb_ind(1,2) = rgb_ind(1,2) + 1;
                ngr_ind(1,2) = ngr_ind(1,2) + 1;
                gli_ind(1,2) = gli_ind(1,2) + 1;
                mgr_ind(1,2) = mgr_ind(1,2) + 1;
                count_otsu_pre(1,(im-2)) = count_otsu_pre(1,(im-2)) + 1;
                ave_S_otsu_pre = ave_S_otsu_pre + hsl_image(i,j);
                if (vari ~= Inf) && (vari ~= -Inf) && (isnan(vari) == false)
                    vi_otsu_pre(1,7) = vi_otsu_pre(1,7) + vari;
                    list_vari(2,vari_ind(1,2)) = vari;
                    vari_ind(1,2) = vari_ind(1,2) + 1;
                    count_otsu_pre_vari(1,(im-2)) = count_otsu_pre_vari(1,(im-2)) + 1;
                end
                if (veg ~= Inf) && (veg ~= -Inf) && (isnan(veg) == false)
                    vi_otsu_pre(1,8) = vi_otsu_pre(1,8) + veg;
                    list_veg(2,veg_ind(1,2)) = veg;
                    veg_ind(1,2) = veg_ind(1,2) + 1;
                    count_otsu_pre_veg(1,(im-2)) = count_otsu_pre_veg(1,(im-2)) + 1;
                end
                if (woeb ~= Inf) && (woeb ~= -Inf) && (isnan(woeb) == false)
                    vi_otsu_pre(1,9) = vi_otsu_pre(1,9) + woeb;
                    list_woeb(2,woeb_ind(1,2)) = woeb;
                    woeb_ind(1,2) = woeb_ind(1,2) + 1;
                    count_otsu_pre_woeb(1,(im-2)) = count_otsu_pre_woeb(1,(im-2)) + 1;
                end
                if (woeb_abs ~= Inf) && (woeb_abs ~= -Inf) && (isnan(woeb_abs) == false)
                    vi_otsu_pre(1,10) = vi_otsu_pre(1,10) + woeb_abs;
                    list_woeb_abs(2,woeb_abs_ind(1,2)) = woeb_abs;
                    woeb_abs_ind(1,2) = woeb_abs_ind(1,2) + 1;
                    count_otsu_pre_woeb_abs(1,(im-2)) = count_otsu_pre_woeb_abs(1,(im-2)) + 1;
                end
            end
            if filter_otsu_post(i,j) == 1
                vi_otsu_post(1,1) = vi_otsu_post(1,1) + exg;
                vi_otsu_post(1,2) = vi_otsu_post(1,2) + exg2;
                vi_otsu_post(1,3) = vi_otsu_post(1,3) + rgb;
                vi_otsu_post(1,4) = vi_otsu_post(1,4) + ngr;
                vi_otsu_post(1,5) = vi_otsu_post(1,5) + gli;
                vi_otsu_post(1,6) = vi_otsu_post(1,6) + mgr;
                list_exg(3,exg_ind(1,3)) = exg;
                list_exg2(3,exg2_ind(1,3)) = exg2;
                list_rgb(3,rgb_ind(1,3)) = rgb;
                list_ngr(3,ngr_ind(1,3)) = ngr;
                list_gli(3,gli_ind(1,3)) = gli;
                list_mgr(3,mgr_ind(1,3)) = mgr;
                exg_ind(1,3) = exg_ind(1,3) + 1;
                exg2_ind(1,3) = exg2_ind(1,3) + 1;
                rgb_ind(1,3) = rgb_ind(1,3) + 1;
                ngr_ind(1,3) = ngr_ind(1,3) + 1;
                gli_ind(1,3) = gli_ind(1,3) + 1;
                mgr_ind(1,3) = mgr_ind(1,3) + 1;
                count_otsu_post(1,(im-2)) = count_otsu_post(1,(im-2)) + 1;
                ave_S_otsu_post = ave_S_otsu_post + hsl_image(i,j);
                if (vari ~= Inf) && (vari ~= -Inf) && (isnan(vari) == false)
                    vi_otsu_post(1,7) = vi_otsu_post(1,7) + vari;
                    list_vari(3,vari_ind(1,3)) = vari;
                    vari_ind(1,3) = vari_ind(1,3) + 1;
                    count_otsu_post_vari(1,(im-2)) = count_otsu_post_vari(1,(im-2)) + 1;
                end
                if (veg ~= Inf) && (veg ~= -Inf) && (isnan(veg) == false)
                    vi_otsu_post(1,8) = vi_otsu_post(1,8) + veg;
                    list_veg(3,veg_ind(1,3)) = veg;
                    veg_ind(1,3) = veg_ind(1,3) + 1;
                    count_otsu_post_veg(1,(im-2)) = count_otsu_post_veg(1,(im-2)) + 1;
                end
                if (woeb ~= Inf) && (woeb ~= -Inf) && (isnan(woeb) == false)
                    vi_otsu_post(1,9) = vi_otsu_post(1,9) + woeb;
                    list_woeb(3,woeb_ind(1,3)) = woeb;
                    woeb_ind(1,3) = woeb_ind(1,3) + 1;
                    count_otsu_post_woeb(1,(im-2)) = count_otsu_post_woeb(1,(im-2)) + 1;
                end
                if (woeb_abs ~= Inf) && (woeb_abs ~= -Inf) && (isnan(woeb_abs) == false)
                    vi_otsu_post(1,10) = vi_otsu_post(1,10) + woeb_abs;
                    list_woeb_abs(3,woeb_abs_ind(1,3)) = woeb_abs;
                    woeb_abs_ind(1,3) = woeb_abs_ind(1,3) + 1;
                    count_otsu_post_woeb_abs(1,(im-2)) = count_otsu_post_woeb_abs(1,(im-2)) + 1;
                end
            end
            if filter_custom(i,j) == 1
                vi_custom(1,1) = vi_custom(1,1) + exg;
                vi_custom(1,2) = vi_custom(1,2) + exg2;
                vi_custom(1,3) = vi_custom(1,3) + rgb;
                vi_custom(1,4) = vi_custom(1,4) + ngr;
                vi_custom(1,5) = vi_custom(1,5) + gli;
                vi_custom(1,6) = vi_custom(1,6) + mgr;
                list_exg(4,exg_ind(1,4)) = exg;
                list_exg2(4,exg2_ind(1,4)) = exg2;
                list_rgb(4,rgb_ind(1,4)) = rgb;
                list_ngr(4,ngr_ind(1,4)) = ngr;
                list_gli(4,gli_ind(1,4)) = gli;
                list_mgr(4,mgr_ind(1,4)) = mgr;
                exg_ind(1,4) = exg_ind(1,4) + 1;
                exg2_ind(1,4) = exg2_ind(1,4) + 1;
                rgb_ind(1,4) = rgb_ind(1,4) + 1;
                ngr_ind(1,4) = ngr_ind(1,4) + 1;
                gli_ind(1,4) = gli_ind(1,4) + 1;
                mgr_ind(1,4) = mgr_ind(1,4) + 1;
                count_custom(1,(im-2)) = count_custom(1,(im-2)) + 1;
                ave_S_custom = ave_S_custom + hsl_image(i,j);
                if (vari ~= Inf) && (vari ~= -Inf) && (isnan(vari) == false)
                    vi_custom(1,7) = vi_custom(1,7) + vari;
                    list_vari(4,vari_ind(1,4)) = vari;
                    vari_ind(1,4) = vari_ind(1,4) + 1;
                    count_custom_vari(1,(im-2)) = count_custom_vari(1,(im-2)) + 1;
                end               
                if (veg ~= Inf) && (veg ~= -Inf) && (isnan(veg) == false)
                    vi_custom(1,8) = vi_custom(1,8) + veg;
                    list_veg(4,veg_ind(1,4)) = veg;
                    veg_ind(1,4) = veg_ind(1,4) + 1;
                    count_custom_veg(1,(im-2)) = count_custom_veg(1,(im-2)) + 1;
                end
                if (woeb ~= Inf) && (woeb ~= -Inf) && (isnan(woeb) == false)
                    vi_custom(1,9) = vi_custom(1,9) + woeb;
                    list_woeb(4,woeb_ind(1,4)) = woeb;
                    woeb_ind(1,4) = woeb_ind(1,4) + 1;
                    count_custom_woeb(1,(im-2)) = count_custom_woeb(1,(im-2)) + 1;
                end
                if (woeb_abs ~= Inf) && (woeb_abs ~= -Inf) && (isnan(woeb_abs) == false)
                    vi_custom(1,10) = vi_custom(1,10) + woeb_abs;
                    list_woeb_abs(4,woeb_abs_ind(1,4)) = woeb_abs;
                    woeb_abs_ind(1,4) = woeb_abs_ind(1,4) + 1;
                    count_custom_woeb_abs(1,(im-2)) = count_custom_woeb_abs(1,(im-2)) + 1;
                end
            end
        end
    end
    
    %all non-problematic indices (no divide by 0 errors):
    vi_131(1,1:6) = vi_131(1,1:6) / count_131(1,(im-2));
    vi_otsu_pre(1,1:6) = vi_otsu_pre(1,1:6) / count_otsu_pre(1,(im-2));
    vi_otsu_post(1,1:6) = vi_otsu_post(1,1:6) / count_otsu_post(1,(im-2));
    vi_custom(1,1:6) = vi_custom(1,1:6) / count_custom(1,(im-2));
    %indices with divide by zero errors (each has to have its own separate count:
    vi_131(1,7) = vi_131(1,7) / count_131_vari(1,(im-2));
    vi_otsu_pre(1,7) = vi_otsu_pre(1,7) / count_otsu_pre_vari(1,(im-2));
    vi_otsu_post(1,7) = vi_otsu_post(1,7) / count_otsu_post_vari(1,(im-2));
    vi_custom(1,7) = vi_custom(1,7) / count_custom_vari(1,(im-2));
    vi_131(1,8) = vi_131(1,8) / count_131_veg(1,(im-2));
    vi_otsu_pre(1,8) = vi_otsu_pre(1,8) / count_otsu_pre_veg(1,(im-2));
    vi_otsu_post(1,8) = vi_otsu_post(1,8) / count_otsu_post_veg(1,(im-2));
    vi_custom(1,8) = vi_custom(1,8) / count_custom_veg(1,(im-2));
    vi_131(1,9) = vi_131(1,9) / count_131_woeb(1,(im-2));
    vi_otsu_pre(1,9) = vi_otsu_pre(1,9) / count_otsu_pre_woeb(1,(im-2));
    vi_otsu_post(1,9) = vi_otsu_post(1,9) / count_otsu_post_woeb(1,(im-2));
    vi_custom(1,9) = vi_custom(1,9) / count_custom_woeb(1,(im-2));
    vi_131(1,10) = vi_131(1,10) / count_131_woeb_abs(1,(im-2));
    vi_otsu_pre(1,10) = vi_otsu_pre(1,10) / count_otsu_pre_woeb_abs(1,(im-2));
    vi_otsu_post(1,10) = vi_otsu_post(1,10) / count_otsu_post_woeb_abs(1,(im-2));
    vi_custom(1,10) = vi_custom(1,10) / count_custom_woeb_abs(1,(im-2));
    
    %get the average saturation values:
    ave_S_131_ar(1,(im-2)) = ave_S_131 / count_131(1,(im-2));
    ave_S_otsu_pre_ar(1,(im-2)) = ave_S_otsu_pre / count_otsu_pre(1,(im-2));
    ave_S_otsu_post_ar(1,(im-2)) = ave_S_otsu_post / count_otsu_post(1,(im-2));
    ave_S_custom_ar(1,(im-2)) = ave_S_custom / count_custom(1,(im-2));
    
    %store the values:
    mat_131((im-2),1:10) = vi_131(:);
    mat_otsu_pre((im-2),1:10) = vi_otsu_pre(:);
    mat_otsu_post((im-2),1:10) = vi_otsu_post(:);
    mat_custom((im-2),1:10) = vi_custom(:);
    %fprintf('%s (ExG 131)	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%d	%d	%.10g\n',list(im).name,mat_131(im-2,1:10),count_131(1,im-2),(m*n),(count_131(1,im-2)/(m*n))*100);
    %fprintf('%s (Custom)	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%.10g	%d	%d	%.10g\n',list(im).name,mat_custom(im-2,1:10),count_custom(1,im-2),(m*n),(count_custom(1,im-2)/(m*n))*100);
end

metadata3;  %<----------NEED TO CHANGE LINES HERE FOR DIFFERENT PLOTS!!!!
lightvals;  %<----------this has the list of ALL field images, so no editing needed

%write the matrices to a file:
fid = fopen(['Plot',num2str(plot_num),'_average_ref_sat_',date,'.csv'],'w');
%fid = fopen(['Plot',num2str(plot_num),'_average_ref_sat_',date,'_redo.csv'],'w');  %this is specifically for the NW2 plots
fprintf(fid,'Filename,Plot,Row Numbers,Filter Type,Genotype,Image,Light Value,Average Saturation,Reference Rep,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n',vi_list{1:10});
fid2 = fopen(['Plot',num2str(plot_num),'_canopy_ref_sat_',date,'.csv'],'w');
%fid2 = fopen(['Plot',num2str(plot_num),'_canopy_ref_sat_',date,'_redo.csv'],'w');  %this is specifically for the NW2 plots
fprintf(fid2,'Filename,Plot,Row Numbers,Filter Type,Genotype,Image,Light Value,Average Saturation,Reference Rep,Pixels Remaining,Total,Percent Cover\n');

for i = 1:num_pics
    %averages:
    fprintf(fid,'%s,%s,%s,ExG 131,%s,%s,%s,%.10g,%s,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_131_ar(1,i),ref_list{i,1},mat_131(i,1:10));
    fprintf(fid,'%s,%s,%s,Otsu pre,%s,%s,%s,%.10g,%s,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_otsu_pre_ar(1,i),ref_list{i,1},mat_otsu_pre(i,1:10));  %might want to make a matrix to hold the thresh values to print here
    fprintf(fid,'%s,%s,%s,Otsu post,%s,%s,%s,%.10g,%s,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_otsu_post_ar(1,i),ref_list{i,1},mat_otsu_post(i,1:10));
    fprintf(fid,'%s,%s,%s,Custom,%s,%s,%s,%.10g,%s,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_custom_ar(1,i),ref_list{i,1},mat_custom(i,1:10));
    
    %canopy coverage:
    fprintf(fid2,'%s,%s,%s,ExG 131,%s,%s,%s,%.10g,%s,%d,%d,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_131_ar(1,i),ref_list{i,1},count_131(1,i),(m*n),(count_131(1,i)/(m*n))*100);
    fprintf(fid2,'%s,%s,%s,Otsu pre,%s,%s,%s,%.10g,%s,%d,%d,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_otsu_pre_ar(1,i),ref_list{i,1},count_otsu_pre(1,i),(m*n),(count_otsu_pre(1,i)/(m*n))*100);  %might want to make a matrix to hold the thresh values to print here
    fprintf(fid2,'%s,%s,%s,Otsu post,%s,%s,%s,%.10g,%s,%d,%d,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_otsu_post_ar(1,i),ref_list{i,1},count_otsu_post(1,i),(m*n),(count_otsu_post(1,i)/(m*n))*100);
    fprintf(fid2,'%s,%s,%s,Custom,%s,%s,%s,%.10g,%s,%d,%d,%.10g\n',pic_list{i,1},plot_list{i,1},row_list{i,1},genotypes{i,1},im_list{i,1},light_list{i,1},ave_S_custom_ar(1,i),ref_list{i,1},count_custom(1,i),(m*n),(count_custom(1,i)/(m*n))*100);
end
fclose(fid);
fclose(fid2);