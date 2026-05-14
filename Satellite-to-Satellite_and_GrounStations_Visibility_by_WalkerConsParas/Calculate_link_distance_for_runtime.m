function [output_Model_distance_curve] = Calculate_link_distance_for_runtime(des_sat_orbitalPlane,des_sat_position_in_OrbitalPlane, ...
    ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane,maximum_link_distance_in_km,sat_radius_in_km,inclination, ...
    Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor,Sum_of_Calculate_Time,orbital_period,Time_step_in_secs)
%CALCULATE_LINK_DISTANCE_BASED_MATHEMATICS_MODEL 此处显示有关此函数的摘要
%   此处显示详细说明

Model_distance_curve = zeros(10,2);
%Column-format:phase + distance
count = 0;

Time_start = 0;
for Time_in_sec = Time_start:Time_step_in_secs:Sum_of_Calculate_Time
    %-----Satellite-------
    orbital_phase = (2 * pi)/orbital_period * Time_in_sec;%unit:second 
    [ref_x,ref_y,ref_z] = calcualte_coords_based_equatorial(ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane, ...
        orbital_phase,sat_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor); 
    [des_x,des_y,des_z] = calcualte_coords_based_equatorial(des_sat_orbitalPlane,des_sat_position_in_OrbitalPlane, ...
        orbital_phase,sat_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor); 

    link_distance_in_km = calculate_inter_orbital_link_distance(ref_x,ref_y,ref_z,des_x,des_y,des_z);%unit:km
    
    link_distance_in_m = link_distance_in_km * 1000;

    if link_distance_in_m >= maximum_link_distance_in_km * 1000
       link_distance_in_m = nan; 
    end
    %storage
    count = count + 1;
    Model_distance_curve(count,1) = Time_in_sec;
    Model_distance_curve(count,2) = link_distance_in_m;
end
Model_distance_curve = Model_distance_curve(1:count,:);
%output
output_Model_distance_curve = Model_distance_curve;
end

