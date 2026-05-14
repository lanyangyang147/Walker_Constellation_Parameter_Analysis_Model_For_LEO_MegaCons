function [output_link_elevation_in_deg] = Calculate_ISL_elevation(link_distance_in_km,sat_radius_in_km)
%CALCULATE_ISL_ELEVATION 此处显示有关此函数的摘要
%   此处显示详细说明
%-------geocentric angle-------based on cosine law---------
k = 2*sat_radius_in_km*sat_radius_in_km;
cos_geoe_angle = (k - link_distance_in_km * link_distance_in_km)/k;
geoe_angle = acos(cos_geoe_angle);

link_elevation_in_value = acos((sat_radius_in_km * sin(geoe_angle))/link_distance_in_km);
%-----value convert to deg------------
link_elevation_in_deg = link_elevation_in_value/(2*pi)*360;

%output
output_link_elevation_in_deg = link_elevation_in_deg;
end

