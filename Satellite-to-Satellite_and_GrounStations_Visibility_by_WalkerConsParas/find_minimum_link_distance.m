function [output_min_distance_based_Math] = find_minimum_link_distance(Math_distance,maximum_link_distance_in_km)
%FIND_MINIMUM_LINK_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明

min_distance_based_Math = maximum_link_distance_in_km * 1000;%unit:m

for k = 1:size(Math_distance,1)
    tmp_distance = Math_distance(k,2);
    if tmp_distance < min_distance_based_Math && tmp_distance ~= 0
        min_distance_based_Math = tmp_distance;
    end
end

%output
output_min_distance_based_Math = min_distance_based_Math;
end

