function [output_Sat_to_ground_link_distance] = Filter_invalid_elevation_AND_distance(Sat_to_ground_link_distance)
%FILTER_INVALID_ELEVATION_AND_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
%Valid_elevation_range: 90-180
Min_elevation = pi / 2;
Max_elevation = pi;


for k = 1:size(Sat_to_ground_link_distance,1)
    tmp_elevation = Sat_to_ground_link_distance(k,2);
    if tmp_elevation >= Min_elevation && tmp_elevation <= Max_elevation
       % do nothing
    else
        Sat_to_ground_link_distance(k,2) = nan;
        Sat_to_ground_link_distance(k,3) = nan;
    end
end



%output
output_Sat_to_ground_link_distance = Sat_to_ground_link_distance;
end

