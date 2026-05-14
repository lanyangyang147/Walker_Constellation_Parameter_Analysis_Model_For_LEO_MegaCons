function [output_Sat_orb_AND_position] = gene_sat_orbit_AND_position(Num_of_sats,Planes_num)
%GENE_SAT_ORBIT_AND_POSITION 此处显示有关此函数的摘要
%   此处显示详细说明
Sum_sats_per_orbit = Num_of_sats / Planes_num;
Sat_orb_AND_position = zeros(Num_of_sats,3);
for k = 1:Num_of_sats
    if mod(k,Sum_sats_per_orbit)
        orbit_id = floor(k / Sum_sats_per_orbit) + 1;
    else
        orbit_id = floor(k / Sum_sats_per_orbit);
    end
    sat_position_in_orbit = k - (orbit_id - 1) * Sum_sats_per_orbit;
    %----storage---
    Sat_orb_AND_position(k,1) = k;
    Sat_orb_AND_position(k,2) = orbit_id - 1;
    Sat_orb_AND_position(k,3) = sat_position_in_orbit - 1;
end
%output
output_Sat_orb_AND_position = Sat_orb_AND_position;
end

