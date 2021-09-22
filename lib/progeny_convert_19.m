function [out] = progeny_convert_19(plot_string, quad)
    %this function accepts a string in the format "row_x_range_y" and
    %converts it to the format "x001 and x002", etc.  It also requires a
    %second input to indicate the plot number (1, 2, 3, 4)
    %actually, let's have it accept the full plot string as input, like
    %"180701_djifc6310_J1_NE_row_1_range_1"
    
    %need to extract the row and range numbers from the input string:
    %the full format will be 'row_x_range_y'
    %indices returned:        ^     ^
    i = strfind(plot_string, 'row_');
    j = strfind(plot_string, 'range_');
    row = str2double(plot_string((i+4):(j-2)));  %need the colon, because could be double digit numbers
    range = str2double(plot_string((j+6):end));
    
    %easy part - range number is simply the 2nd digit in the plot number, but in
    %reverse:
    %Progeny     ours
    %Range 1     x5xx
    %Range 2     x4xx
    %Range 3     x3xx
    %Range 4     x2xx
    %Range 5     x1xx
    %Range 6     x0xx
    if range == 1
        new_range = 5;
    elseif range == 2
        new_range = 4;
    elseif range == 3
        new_range = 3;
    elseif range == 4
        new_range = 2;
    elseif range == 5
        new_range = 1;
    elseif range == 6
        new_range = 0;
    end
    
    %hard part - need to convert from Row 1, Row 2, etc. to xx01 and xx02,
    %etc.:
    %Progeny row number, times two, is the SECOND row
    plot1 = row * 2;
    plot1 = 84 - plot1 + 1;
    plot2 = plot1 + 1;
    
    %have to check if they are less than 10, because we need leading 0s
    if plot1 < 10
        plot1_str = ['0', num2str(plot1)];
    else
        plot1_str = num2str(plot1);
    end
    if plot2 < 10
        plot2_str = ['0', num2str(plot2)];
    else
        plot2_str = num2str(plot2);
    end
    
    out_str1 = [num2str(quad), num2str(new_range), plot1_str];
    out_str2 = [num2str(quad), num2str(new_range), plot2_str];
    
    out = [out_str1, ' and ', out_str2];
end