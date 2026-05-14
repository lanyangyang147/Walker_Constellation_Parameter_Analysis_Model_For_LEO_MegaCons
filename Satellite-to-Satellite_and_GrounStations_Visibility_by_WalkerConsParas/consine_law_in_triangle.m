function [output_EI_added_half_PI] = consine_law_in_triangle(Sat_to_Facility_link_distance_in_km,sat_radius_in_km,earth_radius_in_km)
%CONSINE_LAW_IN_TRIANGLE 此处显示有关此函数的摘要
%   此处显示详细说明

cos_angle = (Sat_to_Facility_link_distance_in_km^2 + earth_radius_in_km^2 - sat_radius_in_km^2) / (2 * Sat_to_Facility_link_distance_in_km * earth_radius_in_km);

EI_added_half_PI = acos(cos_angle);

%fprintf('angle = %d\n',EI_added_half_PI / (2*pi) * 360);
% 90 -180 deg
%output
output_EI_added_half_PI = EI_added_half_PI - pi/2;
end

