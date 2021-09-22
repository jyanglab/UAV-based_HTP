clear;
clc;

%NOTE: the 'phenix' variable is needed solely to distinguish the east plots
%(generated using the older Progeny) from the west plots (generated using
%the newer version Phenix) - indexing in some cases differs between the two
%versions, so we need to tie this variable to if statements

for q = 1:24  %we have 12 dates and 4 quadrants per date
    if q == 1
        folder_name = '190706_djifc6310_J6_NE_plot_images';
        date = 'J6';
        date2 = '7-6';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 2
        folder_name = '190706_djifc6310_J6_SE_plot_images';
        date = 'J6';
        date2 = '7-6';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 3
        folder_name = '190812_djifc6310s_Aug12_NE_plot_images';
        date = 'Aug12';
        date2 = '8-12';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 4
        folder_name = '190812_djifc6310s_Aug12_SE_plot_images';
        date = 'Aug12';
        date2 = '8-12';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 5
        folder_name = '190814_djifc6310s_Aug14_NE_plot_images';
        date = 'Aug14';
        date2 = '8-14';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 6
        folder_name = '190814_djifc6310s_Aug14_SE_plot_images';
        date = 'Aug14';
        date2 = '8-14';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 7
        folder_name = '190816_djifc6310s_Aug16_NE_plot_images';
        date = 'Aug16';
        date2 = '8-16';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 8
        folder_name = '190816_djifc6310s_Aug16_SE_plot_images';
        date = 'Aug16';
        date2 = '8-16';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 9
        folder_name = '190820_djifc6310s_Aug20_NE_plot_images';
        date = 'Aug20';
        date2 = '8-20';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 10
        folder_name = '190820_djifc6310s_Aug20_SE_plot_images';
        date = 'Aug20';
        date2 = '8-20';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 11
        folder_name = '190822_djifc6310s_Aug22_NE_plot_images';
        date = 'Aug22';
        date2 = '8-22';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 12
        folder_name = '190822_djifc6310s_Aug22_SE_plot_images';
        date = 'Aug22';
        date2 = '8-22';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 13
        folder_name = '190823_djifc6310_Aug23_NE_plot_images';
        date = 'Aug23';
        date2 = '8-23';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 14
        folder_name = '190823_djifc6310_Aug23_SE_plot_images';
        date = 'Aug23';
        date2 = '8-23';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 15
        folder_name = '190827_djifc6310_Aug26_NE_plot_images';
        date = 'Aug26';
        date2 = '8-26';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 16
        folder_name = '190827_djifc6310_Aug26_SE_plot_images';
        date = 'Aug26';
        date2 = '8-26';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 17
        folder_name = '190830_djifc6310s_Aug30_NE_plot_images';
        date = 'Aug30';
        date2 = '8-30';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 18
        folder_name = '190830_djifc6310s_Aug30_SE_plot_images';
        date = 'Aug30';
        date2 = '8-30';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 19
        folder_name = '190901_djifc6310s_Sept1_NE_plot_images';
        date = 'Sept1';
        date2 = '9-1';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 20
        folder_name = '190901_djifc6310s_Sept1_SE_plot_images';
        date = 'Sept1';
        date2 = '9-1';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 21
        folder_name = '190903_djifc6310s_Sept3_NE_plot_images';
        date = 'Sept3';
        date2 = '9-3';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 22
        folder_name = '190903_djifc6310s_Sept3_SE_plot_images';
        date = 'Sept3';
        date2 = '9-3';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 23
        folder_name = '190905_djifc6310s_Sept5_NE_plot_images';
        date = 'Sept5';
        date2 = '9-5';
        plot_num = 1;
        quadrant = 'NE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 24
        folder_name = '190905_djifc6310s_Sept5_SE_plot_images';
        date = 'Sept5';
        date2 = '9-5';
        plot_num = 3;
        quadrant = 'SE';
        year = '19';
        year2 = '2019';
        phenix = false;
    elseif q == 25
        folder_name = '190706_djifc6310_J6_NW_plot_images';
        date = 'J6';
        date2 = '7-6';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 26
        folder_name = '190706_djifc6310_J6_SW_plot_images';
        date = 'J6';
        date2 = '7-6';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 27
        folder_name = '190812_djifc6310s_Aug12_NW_plot_images';
        date = 'Aug12';
        date2 = '8-12';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 28
        folder_name = '190812_djifc6310s_Aug12_SW_plot_images';
        date = 'Aug12';
        date2 = '8-12';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 29
        folder_name = '190814_djifc6310s_Aug14_NW_plot_images';
        date = 'Aug14';
        date2 = '8-14';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 30
        folder_name = '190814_djifc6310s_Aug14_SW_plot_images';
        date = 'Aug14';
        date2 = '8-14';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 31
        folder_name = '190816_djifc6310s_Aug16_NW_plot_images';
        date = 'Aug16';
        date2 = '8-16';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 32
        folder_name = '190816_djifc6310s_Aug16_SW_plot_images';
        date = 'Aug16';
        date2 = '8-16';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 33
        folder_name = '190820_djifc6310s_Aug20_NW_plot_images';
        date = 'Aug20';
        date2 = '8-20';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 34
        folder_name = '190820_djifc6310s_Aug20_SW_plot_images';
        date = 'Aug20';
        date2 = '8-20';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 35
        folder_name = '190822_djifc6310s_Aug22_NW_plot_images';
        date = 'Aug22';
        date2 = '8-22';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 36
        folder_name = '190822_djifc6310s_Aug22_SW_plot_images';
        date = 'Aug22';
        date2 = '8-22';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 37
        folder_name = '190823_djifc6310_Aug23_NW_plot_images';
        date = 'Aug23';
        date2 = '8-23';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 38
        folder_name = '190823_djifc6310_Aug23_SW_plot_images';
        date = 'Aug23';
        date2 = '8-23';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 39
        folder_name = '190827_djifc6310_Aug26_NW_plot_images';
        date = 'Aug26';
        date2 = '8-26';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 40
        folder_name = '190827_djifc6310_Aug26_SW_plot_images';
        date = 'Aug26';
        date2 = '8-26';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 41
        folder_name = '190830_djifc6310s_Aug30_NW_plot_images';
        date = 'Aug30';
        date2 = '8-30';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 42
        folder_name = '190830_djifc6310s_Aug30_SW_plot_images';
        date = 'Aug30';
        date2 = '8-30';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 43
        folder_name = '190901_djifc6310s_Sept1_NW_plot_images';
        date = 'Sept1';
        date2 = '9-1';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 44
        folder_name = '190901_djifc6310s_Sept1_SW_plot_images';
        date = 'Sept1';
        date2 = '9-1';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 45
        folder_name = '190903_djifc6310s_Sept3_NW_plot_images';
        date = 'Sept3';
        date2 = '9-3';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 46
        folder_name = '190903_djifc6310s_Sept3_SW_plot_images';
        date = 'Sept3';
        date2 = '9-3';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 47
        folder_name = '190905_djifc6310s_Sept5_NW_plot_images';
        date = 'Sept5';
        date2 = '9-5';
        plot_num = 2;
        quadrant = 'NW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 48
        folder_name = '190905_djifc6310s_Sept5_SW_plot_images';
        date = 'Sept5';
        date2 = '9-5';
        plot_num = 4;
        quadrant = 'SW';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 49
        folder_name = '190706_djifc6310_J6_NW2_plot_images';
        date = 'J6';
        date2 = '7-6';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 50
        folder_name = '190812_djifc6310s_Aug12_NW2_plot_images';
        date = 'Aug12';
        date2 = '8-12';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 51
        folder_name = '190814_djifc6310s_Aug14_NW2_plot_images';
        date = 'Aug14';
        date2 = '8-14';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 52
        folder_name = '190816_djifc6310s_Aug16_NW2_plot_images';
        date = 'Aug16';
        date2 = '8-16';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 53
        folder_name = '190820_djifc6310s_Aug20_NW2_plot_images';
        date = 'Aug20';
        date2 = '8-20';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 54
        folder_name = '190822_djifc6310s_Aug22_NW2_plot_images';
        date = 'Aug22';
        date2 = '8-22';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 55
        folder_name = '190823_djifc6310_Aug23_NW2_plot_images';
        date = 'Aug23';
        date2 = '8-23';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 56
        folder_name = '190827_djifc6310_Aug26_NW2_plot_images';
        date = 'Aug26';
        date2 = '8-26';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 57
        folder_name = '190830_djifc6310s_Aug30_NW2_plot_images';
        date = 'Aug30';
        date2 = '8-30';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 58
        folder_name = '190901_djifc6310s_Sept1_NW2_plot_images';
        date = 'Sept1';
        date2 = '9-1';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 59
        folder_name = '190903_djifc6310s_Sept3_NW2_plot_images';
        date = 'Sept3';
        date2 = '9-3';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    elseif q == 60
        folder_name = '190905_djifc6310s_Sept5_NW2_plot_images';
        date = 'Sept5';
        date2 = '9-5';
        plot_num = 2;
        quadrant = 'NW2';
        year = '19';
        year2 = '2019';
        phenix = true;
    end
    
    vi_script;
end