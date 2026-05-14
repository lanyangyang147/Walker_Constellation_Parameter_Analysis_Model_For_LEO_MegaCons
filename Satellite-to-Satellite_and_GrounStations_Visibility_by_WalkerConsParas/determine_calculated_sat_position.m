function [output_Calculate_Sat_position] = determine_calculated_sat_position(Calculate_Sats_Num,Sat_orb_AND_position)
%DETERMINE_CALCULATED_SAT_POSITION 此处显示有关此函数的摘要
%   此处显示详细说明

%Calculate_Sats_Num,Sat_orb_AND_position,Num_of_sats_per_orbitalPlane
Calculate_Sat_position = zeros(size(Calculate_Sats_Num,1),size(Sat_orb_AND_position,2));

for k = 1:size(Calculate_Sats_Num,1)
    %orbitNum + SatNum (orbitNum:1...24 + SatNum：1...66)
    tmp_orbit_num = Calculate_Sats_Num(k,1) - 1;%convert to range:0...
    tmp_orbit_sat_num = Calculate_Sats_Num(k,2) - 1;%convert to range:0...
    %----- determine row----- 
    for m = 1:size(Sat_orb_AND_position,1)
        if tmp_orbit_num == Sat_orb_AND_position(m,2) && tmp_orbit_sat_num == Sat_orb_AND_position(m,3)
            row =  m;
            fprintf('row = %d\n',m);
            break;
        end
    end
    Calculate_Sat_position(k,:) = Sat_orb_AND_position(row,:);
end

%output
output_Calculate_Sat_position = Calculate_Sat_position;
end

