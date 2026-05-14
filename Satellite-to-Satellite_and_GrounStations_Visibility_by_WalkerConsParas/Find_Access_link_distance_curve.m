function [output_Access_distance_curve] = Find_Access_link_distance_curve(sat1_string,sat2_string,ISL_Distance_Data,orbital_period)
%FIND_ACCESS_LINK_DISTANCE_CURVE 此处显示有关此函数的摘要
%   此处显示详细说明
connect_str = '-To-';
Access_name_string1 = [sat1_string connect_str sat2_string];
Access_name_string2 = [sat2_string connect_str sat1_string];

for k = 1:size(ISL_Distance_Data,1)
    tmp_string = ISL_Distance_Data{k,1};
    if strcmp(tmp_string,Access_name_string1) || strcmp(tmp_string,Access_name_string2)
        flag = 1;
        des_row = k;
        break;
    elseif k == size(ISL_Distance_Data,1)
        flag = 0;
    end
end

if flag
    Access_distance_curve = cell2mat(ISL_Distance_Data(des_row,2:3));
    %------find the access data in one orbital period
    for k = 1:size(Access_distance_curve,1)
        if Access_distance_curve(k,1) > orbital_period
            end_row = k - 1;
            break;
        end
    end
    Access_distance_curve = Access_distance_curve(1:end_row,:);
else
    Access_distance_curve = nan;
end
%output
output_Access_distance_curve = Access_distance_curve;
end

