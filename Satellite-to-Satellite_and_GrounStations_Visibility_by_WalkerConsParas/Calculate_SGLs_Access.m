function [output_Facility_To_Sats_Link_Access] = Calculate_SGLs_Access(Sat_orb_AND_position,Time_step_in_seconds,Time_start,Time_end,orbital_period,Init_UTC_Time,Facility_ECEF, ...
    sat_radius_in_km,earth_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor,GS_Min_Elevation)
%CALCULATE_SGLS_ACCESS 此处显示有关此函数的摘要
%   此处显示详细说明
Facility_To_Sats_Link_Access  = cell(size(Sat_orb_AND_position,1),4);
%column-format: SatName + SatNum + orbit-id + sat-id + Access
for k = 1:size(Sat_orb_AND_position,1)
    Sat_num = Sat_orb_AND_position(k,1);
    orbit_id = Sat_orb_AND_position(k,2);
    sat_id = Sat_orb_AND_position(k,3);
    %--------calculated the facility-to-satellite link-----
    Sat_to_ground_link_distance = zeros(floor(orbital_period),4)*nan;
    %Column-format:time (phase) + Access +elevation + distance
    count = 0;
    %----------First Calculated---Duration：1 minutes---------------
    for Time = Time_start:Time_step_in_seconds:Time_end
        %-----Facility-------
        UTC_Time = update_UTC_Time(Time,Init_UTC_Time);

        [Facility_ECI_x,Facility_ECI_y,Facility_ECI_z] = Convert_Facility_coordinate(UTC_Time,Facility_ECEF);
        %-----Satellite-------
        orbital_phase = (2 * pi)/orbital_period * (Time);%unit:second 
        [Sat_ECI_x,Sat_ECI_y,Sat_ECI_z] = calcualte_coords_based_equatorial(orbit_id,sat_id,orbital_phase,sat_radius_in_km,inclination,Num_of_orbital_planes,Num_of_sats_per_orbitalPlane,Phase_factor); 
        Sat_to_Facility_link_distance_in_km = calculate_inter_orbital_link_distance(Sat_ECI_x,Sat_ECI_y,Sat_ECI_z,Facility_ECI_x,Facility_ECI_y,Facility_ECI_z);%unit:km
        Elevation = consine_law_in_triangle(Sat_to_Facility_link_distance_in_km,sat_radius_in_km,earth_radius_in_km);
        %-----Check whether is valid
        Valid_flag = Whether_Elevation_is_valid(GS_Min_Elevation,Elevation);
        %-----Store result-------
        count = count + 1;
        Sat_to_ground_link_distance(count,1) = Time;
        if Valid_flag
            Sat_to_ground_link_distance(count,2) = 1;
            Sat_to_ground_link_distance(count,3) = Elevation * 180 / pi;%unit:deg
            Sat_to_ground_link_distance(count,4) = Sat_to_Facility_link_distance_in_km;       
        end
    end
    Sat_to_ground_link_distance = Sat_to_ground_link_distance(1:count,:);
    %-------storage----------
    Facility_To_Sats_Link_Access{k,1} = convert_orb_AND_position_to_sat_string(orbit_id,sat_id);
    Facility_To_Sats_Link_Access{k,2} = Sat_num;
    Facility_To_Sats_Link_Access{k,3} = orbit_id;
    Facility_To_Sats_Link_Access{k,4} = sat_id;
    Facility_To_Sats_Link_Access{k,5} = Sat_to_ground_link_distance;
    %fprintf('----the %d-th facility-to-ground link is calculated!\n',k);
end
%output
output_Facility_To_Sats_Link_Access = Facility_To_Sats_Link_Access;
end

