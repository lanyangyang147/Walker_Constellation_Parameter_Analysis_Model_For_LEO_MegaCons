function [output_Model_distance_curve] = Calculate_link_distance(des_sat_orbitalPlane,des_sat_position_in_OrbitalPlane, ...
    ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane,maximum_link_distance_in_km,sat_radius_in_km,inclination, ...
    Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor,Num_of_Orbital_Period_for_ISL,orbital_period,Time_step_in_secs,Min_ISL_elevation,Max_ISL_elevation)
%CALCULATE_LINK_DISTANCE_BASED_MATHEMATICS_MODEL 此处显示有关此函数的摘要
%   此处显示详细说明

%sat_radius_in_km = earth_radius_in_km + altitude_in_km;

Model_distance_curve = zeros(10,3);
%Column-format:phase + distance + elevation
count = 0;

Time_start = 0;
for Time_in_sec = Time_start:Time_step_in_secs:Num_of_Orbital_Period_for_ISL * orbital_period
    %-----Satellite-------
    orbital_phase = (2 * pi)/orbital_period * Time_in_sec;%unit:second 
    [ref_x,ref_y,ref_z] = calcualte_coords_based_equatorial(ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane, ...
        orbital_phase,sat_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor); 
    [des_x,des_y,des_z] = calcualte_coords_based_equatorial(des_sat_orbitalPlane,des_sat_position_in_OrbitalPlane, ...
        orbital_phase,sat_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor); 
    %------distance-------------
    link_distance_in_km = calculate_inter_orbital_link_distance(ref_x,ref_y,ref_z,des_x,des_y,des_z);%unit:km
    link_distance_in_m = link_distance_in_km * 1000;
    %-----elevation-------------
    link_elevation_in_deg = Calculate_ISL_elevation(link_distance_in_km,sat_radius_in_km);
    %-------judge--------------
    if (link_distance_in_m <= maximum_link_distance_in_km * 1000) && (link_elevation_in_deg >= Min_ISL_elevation) && (link_elevation_in_deg <= Max_ISL_elevation)   
        % do nothing
    else
       link_distance_in_m = nan;
       link_elevation_in_deg = nan;
    end    
%     if link_distance_in_m >= maximum_link_distance_in_km * 1000
%        link_distance_in_m = nan; 
%     end
    %storage
    count = count + 1;
    Model_distance_curve(count,1) = Time_in_sec;
    Model_distance_curve(count,2) = link_distance_in_m;
    Model_distance_curve(count,3) = link_elevation_in_deg;
end
Model_distance_curve = Model_distance_curve(1:count,:);
%output
output_Model_distance_curve = Model_distance_curve;
end

