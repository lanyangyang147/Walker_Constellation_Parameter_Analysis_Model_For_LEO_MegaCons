function [output_flag,output_des_row] = find_valid_distance_data(phase_value,link_distance_res)
%FIND_VALID_DISTANCE_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
flag = 0;
for k = 1:size(link_distance_res,1)
    if link_distance_res(k,1) == phase_value
       des_row = k;
       flag = 1;
       break;
    end
end
if ~flag
    des_row = nan;
end
%output
output_flag = flag;
output_des_row = des_row;
end

