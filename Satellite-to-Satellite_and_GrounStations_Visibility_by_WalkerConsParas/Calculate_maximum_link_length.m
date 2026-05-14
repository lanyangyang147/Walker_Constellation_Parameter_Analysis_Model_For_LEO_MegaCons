function [output_maximum_link_distance] = Calculate_maximum_link_length(altitude,Protect_clearance_altitude,earth_radius)
%CALCULATE_MAXIMUM_LINK_LENGTH 此处显示有关此函数的摘要
%   此处显示详细说明
hypot_side = earth_radius + altitude;
right_angle_side = earth_radius + Protect_clearance_altitude;

Half_link_length = sqrt(hypot_side^2 - right_angle_side^2);

maximum_link_distance = Half_link_length * 2;%unit:km

%output
output_maximum_link_distance = maximum_link_distance;
end

