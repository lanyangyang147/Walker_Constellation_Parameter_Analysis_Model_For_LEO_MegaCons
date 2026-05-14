function [output_x_coordinate,output_y_coordinate,output_z_coordinate] = calcualte_coords_based_equatorial(j_th_orbital_plane,k_th_sat_in_orbit,orbital_phase,radius,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor)
%CALCUALTE_X_COORD_BASED_EQUATORIAL 此处显示有关此函数的摘要
%   此处显示详细说明

common_element1 = sin(orbital_phase + 2 * pi * (Phase_factor * j_th_orbital_plane/(Num_of_orbital_planes * Num_of_sats_per_orbitalPlane) + k_th_sat_in_orbit/Num_of_sats_per_orbitalPlane));
common_element2 = cos(orbital_phase + 2 * pi * (Phase_factor * j_th_orbital_plane/(Num_of_orbital_planes * Num_of_sats_per_orbitalPlane) + k_th_sat_in_orbit/Num_of_sats_per_orbitalPlane));

common_part1 = -1 * radius * cos(inclination) * common_element1;
common_part2 = radius * common_element2;

x_coordinate = common_part1 * sin(2 * pi * j_th_orbital_plane / Num_of_orbital_planes) + common_part2 * cos(2 * pi * j_th_orbital_plane / Num_of_orbital_planes);
y_coordinate = -1 * common_part1 * cos(2 * pi * j_th_orbital_plane / Num_of_orbital_planes) + common_part2 * sin(2 * pi * j_th_orbital_plane / Num_of_orbital_planes);
z_coordinate = radius *sin(inclination) * common_element1;
%output
output_x_coordinate = x_coordinate;
output_y_coordinate = y_coordinate;
output_z_coordinate = z_coordinate;
end

