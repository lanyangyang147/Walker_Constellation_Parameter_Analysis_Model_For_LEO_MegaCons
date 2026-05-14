function [output_All_ISLs_distance_data] = determine_other_need_calculated_sats(ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane,Sat_orb_AND_position)
%DETERMINE_OTHER_NEED_CALCULATED_SATS 此处显示有关此函数的摘要
%   此处显示详细说明
%connect_str = '-To-';
ref_sat_string = convert_orb_AND_position_to_sat_string(ref_sat_orbitalPlane,ref_sat_position_in_OrbitalPlane);

All_ISLs_distance_data = cell(size(Sat_orb_AND_position,1),5);
%Column-Format:ref_sat_str + des_sat_str + des_sat_orbitalPlane + des_sat_position_in_OrbitalPlane
              % + distance data(mathematical model) 
count = 0;
for k = 1:size(Sat_orb_AND_position,1)
    tmp_orb_id = Sat_orb_AND_position(k,2);
    if tmp_orb_id ~= ref_sat_orbitalPlane
        count = count + 1;
        tmp_position_id_in_OrbitPlane = Sat_orb_AND_position(k,3);
        tmp_sat_string = convert_orb_AND_position_to_sat_string(tmp_orb_id,tmp_position_id_in_OrbitPlane);
        %------storage---------
        All_ISLs_distance_data{count,1} = ref_sat_string;
        All_ISLs_distance_data{count,2} = tmp_sat_string;
        All_ISLs_distance_data{count,3} = tmp_orb_id;
        All_ISLs_distance_data{count,4} = tmp_position_id_in_OrbitPlane;
    end
end
All_ISLs_distance_data = All_ISLs_distance_data(1:count,:);
%output
output_All_ISLs_distance_data = All_ISLs_distance_data;
end

