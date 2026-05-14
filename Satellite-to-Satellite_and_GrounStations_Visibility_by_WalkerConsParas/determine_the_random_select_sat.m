function [output_ref_sat_orbitalPlane,output_ref_sat_position_in_OrbitalPlane,output_SatName] = determine_the_random_select_sat(rand_sat_num,Sat_orb_AND_position)
%DETERMINE_THE_RANDOM_SELECT_SAT 此处显示有关此函数的摘要
%   此处显示详细说明
for k = 1:size(Sat_orb_AND_position,1)
    if Sat_orb_AND_position(k,1) == rand_sat_num
        ref_sat_orbitalPlane = Sat_orb_AND_position(k,2);
        ref_sat_position_in_OrbitalPlane = Sat_orb_AND_position(k,3);
        break;
    end
end

SatName = gene_sat_name(ref_sat_orbitalPlane + 1,ref_sat_position_in_OrbitalPlane + 1);
%output
output_ref_sat_orbitalPlane = ref_sat_orbitalPlane;
output_ref_sat_position_in_OrbitalPlane = ref_sat_position_in_OrbitalPlane;
output_SatName = SatName;
end

