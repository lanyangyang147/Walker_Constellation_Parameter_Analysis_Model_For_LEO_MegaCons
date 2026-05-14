
ISL_Access_AND_distance_data = determine_other_need_calculated_sats(ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane,Sat_orb_AND_position);
%Column-Format:ref_sat_str + des_sat_str + des_sat_orbitalPlane + des_sat_position_in_OrbitalPlane
              % + distance data(mathematical model)
for k = 1:size(ISL_Access_AND_distance_data,1)
    %---- Generate link distance (Mathematics) --------
    des_sat_orbitalPlane = ISL_Access_AND_distance_data{k,3};
    des_sat_position_in_OrbitalPlane = ISL_Access_AND_distance_data{k,4};
    Model_Init_distance_curve = Calculate_link_distance_for_runtime(des_sat_orbitalPlane,des_sat_position_in_OrbitalPlane,ref_sat_orbitalPlane, ...
        ref_sat_position_in_OrbitalPlane,maximum_link_distance_in_km,sat_radius_in_km,inclination,Num_of_orbital_planes, ...
        Num_of_sats_per_orbitalPlane,Phase_factor,Sum_of_Calculate_Time,orbital_period,Time_step_in_secs);
    Model_distance_curve = Filter_no_Accessed_link_distance(Model_Init_distance_curve);
    if size(Model_distance_curve,1) ~= 1
        Access_AND_distance = process_middle_result(Model_distance_curve);
            %Column-format:time + Access + Disyance_in_km
    else
        Access_AND_distance = Model_distance_curve;
    end
    %---- storage --------
    ISL_Access_AND_distance_data{k,5} = Access_AND_distance;
    %fprintf('For sigle ISL, k = %d\n',k);
end



