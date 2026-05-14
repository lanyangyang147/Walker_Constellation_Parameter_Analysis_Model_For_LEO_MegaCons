function [output_Sats_Raan_Phase] = convert_range(Sats_Raan_Phase)
%CONVERT_RANGE 此处显示有关此函数的摘要
%   此处显示详细说明
for k = 1:size(Sats_Raan_Phase,1)
    tmp_Raan = Sats_Raan_Phase(k,2);
    tmp_Phase = Sats_Raan_Phase(k,3);
    if tmp_Raan > pi && tmp_Raan <= 2*pi
        tmp_Raan = tmp_Raan - 2 * pi;
    end
    if tmp_Phase > pi && tmp_Phase <= 2*pi
        tmp_Phase = tmp_Phase - 2 * pi;
    end    
    %storage
    Sats_Raan_Phase(k,2) = tmp_Raan;
    Sats_Raan_Phase(k,3) = tmp_Phase;
end
%output
output_Sats_Raan_Phase = Sats_Raan_Phase;
end

