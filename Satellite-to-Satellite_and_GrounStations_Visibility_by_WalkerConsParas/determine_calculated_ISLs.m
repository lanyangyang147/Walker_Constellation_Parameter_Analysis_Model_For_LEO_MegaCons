function [output_Need_Calc_ISL_distance_data] = determine_calculated_ISLs(Calculate_Sats_Num,All_ISLs_distance_data)
%DETERMINE_CALCULATED_ISLS 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(All_ISLs_distance_data);
Need_Calc_ISL_distance_data =cell(row,column);

for k = 1:size(Calculate_Sats_Num,1)
    %orbitNum + SatNum (orbitNum:1...24 + SatNum：1...66)
    tmp_orbit_num = Calculate_Sats_Num(k,1) - 1;%convert to range:0...
    tmp_orbit_sat_num = Calculate_Sats_Num(k,2) - 1;%convert to range:0...
    %----- determine row----- 
    for m = 1:size(All_ISLs_distance_data,1)
        if tmp_orbit_num == All_ISLs_distance_data{m,3} && tmp_orbit_sat_num == All_ISLs_distance_data{m,4}
            row =  m;
            %fprintf('row = %d\n',m);
            break;
        end
    end
    Need_Calc_ISL_distance_data(k,:) = All_ISLs_distance_data(row,:);
end
%output
output_Need_Calc_ISL_distance_data = Need_Calc_ISL_distance_data(1:size(Calculate_Sats_Num,1),:);
end

