function [output_link_distance] = calculate_inter_orbital_link_distance(ref_x_coord,ref_y_coord,ref_z_coord,x_coord,y_coord,z_coord)
%CALCULATE_INTER_ORBITAL_LINK_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明

%ref_x_coord,ref_y_coord,ref_z_coord,x_coord,x_coord,z_coord

x_diff = (ref_x_coord - x_coord)^2;
y_diff = (ref_y_coord - y_coord)^2;
z_diff = (ref_z_coord - z_coord)^2;

link_distance = sqrt(x_diff + y_diff + z_diff);%unit:km
%output
output_link_distance = link_distance;
end

