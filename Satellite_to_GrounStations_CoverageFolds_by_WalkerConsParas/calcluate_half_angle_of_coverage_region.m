function [output_coverage_half_angle] = calcluate_half_angle_of_coverage_region(Earth_radius,orbit_altitude,Min_elevation)
%CALCLUATE_HALF_ANGLE_OF_COVERAGE_REGION 此处显示有关此函数的摘要
%   此处显示详细说明

coverage_half_angle = acos(Earth_radius * cos(Min_elevation)/(Earth_radius + orbit_altitude)) - Min_elevation;

%output
output_coverage_half_angle = coverage_half_angle;
end

