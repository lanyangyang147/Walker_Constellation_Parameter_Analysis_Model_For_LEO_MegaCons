function [output_Now_Sats_Raan_Phase] = update_Raan_AND_Phase_for_all_sats(time,Raan_change_rate,Phase_change_rate,Sats_Raan_Phase)
%UPDATE_RAAN_AND_PHASE_FOR_ALL_SATS 此处显示有关此函数的摘要
%   此处显示详细说明
Now_Sats_Raan_Phase = zeros(size(Sats_Raan_Phase,1),size(Sats_Raan_Phase,2));
Now_Sats_Raan_Phase(:,1) = Sats_Raan_Phase(:,1);
for k = 1:size(Sats_Raan_Phase,1)
    tmp_Raan = Sats_Raan_Phase(k,2);
    tmp_Phase = Sats_Raan_Phase(k,3);
    now_Raan  = tmp_Raan - time * Raan_change_rate;
    now_Phase = tmp_Phase + time * Phase_change_rate;
    if now_Raan <= 2 * pi && now_Raan > pi
       now_Raan = now_Raan - 2 * pi;
    end
    if now_Phase <= 2 * pi && now_Phase > pi
       now_Phase = now_Phase - 2 * pi;
    end    
    %----storage---------
    Now_Sats_Raan_Phase(k,2) = now_Raan;
    Now_Sats_Raan_Phase(k,3) = now_Phase;
end
%output
output_Now_Sats_Raan_Phase = Now_Sats_Raan_Phase;
end

