function [output_Sats_Raan_Phase] = sat_converts_raan_AND_phase(Num_of_sats,Planes_num,F_factor)
%SAT_CONVERTS_RAAN_AND_PHASE 此处显示有关此函数的摘要
%   此处显示详细说明

Sats_Raan_Phase = zeros(Num_of_sats,3);
count = 0;
%column-format:sat-index + raan + phase
for  sat_index = 0:Num_of_sats-1
    [Raan_coordinate,Phase_coordinate] = generate_sats_coordinate_simplified(sat_index,Num_of_sats,Planes_num,F_factor);

    %fprintf("---%d:-->(%d,%d)-----\n",sat_index + 1,Raan_coordinate,Phase_coordinate);
    %-------storage-------
    count = count + 1;
    Sats_Raan_Phase(count,1) = sat_index + 1;
    Sats_Raan_Phase(count,2) = Raan_coordinate;
    Sats_Raan_Phase(count,3) = Phase_coordinate;
end

%output
output_Sats_Raan_Phase = Sats_Raan_Phase;
end

