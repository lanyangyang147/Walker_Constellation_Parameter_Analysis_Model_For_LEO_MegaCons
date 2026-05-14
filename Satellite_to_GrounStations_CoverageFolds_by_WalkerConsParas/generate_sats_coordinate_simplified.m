function [output_Raan_coordinate,output_Phase_coordinate] = generate_sats_coordinate_simplified(sat_index,Num_of_sats,Planes_num,F_factor)
%GENERATE_SATS_COORDINATE_ON_2DMAPPING 此处显示有关此函数的摘要
%   此处显示详细说明
%-----Raan----------
tmp = floor(sat_index * Planes_num / Num_of_sats);

Raan_coordinate = tmp * (2 * pi / Planes_num);
%-----Phase----------
tmp2 = rem(sat_index,Num_of_sats/Planes_num);% - 1;
Phase_coordinate = tmp * (2 * pi * F_factor / Num_of_sats) + tmp2 * (2 * pi * Planes_num / Num_of_sats);

if Raan_coordinate < 0 && abs(Raan_coordinate) < 2 * pi
   Raan_coordinate = Raan_coordinate + 2 * pi;
end
if Phase_coordinate < 0 && abs(Phase_coordinate) < 2 * pi
   Phase_coordinate = Phase_coordinate + 2 * pi;
end
%output
output_Raan_coordinate = Raan_coordinate;
output_Phase_coordinate = Phase_coordinate;
end

