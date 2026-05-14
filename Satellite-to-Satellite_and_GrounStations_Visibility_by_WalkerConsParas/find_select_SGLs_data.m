function [outputA_selected_data] = find_select_SGLs_data(Calculate_Sats_Num,source_data)
%FIND_SELECT_SGLS_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(source_data);
selected_data = cell(row,column);
count = 0;
for k = 1:size(Calculate_Sats_Num,1)
    orbit_num = Calculate_Sats_Num(k,1);
    orbit_sat_num = Calculate_Sats_Num(k,2);
    Sat_name_str = gene_sat_name(orbit_num,orbit_sat_num);
    for m = 1:size(source_data,1)
        if contains(source_data{m,1},Sat_name_str)
            corresponding_row = m;
            break;
        end
    end
    %---------storage--------
    count = count + 1;
    selected_data(count,:) = source_data(corresponding_row,:);
end

selected_data = selected_data(1:count,:);
%output
outputA_selected_data = selected_data;
end

