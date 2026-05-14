function [output_Accessed_sats] = Judge_whether_is_Acccessed_sats(Sats_Raan_Phase,Target_latitude,Target_longitude,orbit_inclination,Alpha_D)
%JUDGE_WHETHER_IS_ACCCESSED_SATS 此处显示有关此函数的摘要
%   此处显示详细说明
% necessary condition
%[Min_phase,Max_phase] = Calculate_phase_range(Target_latitude,Alpha_D,orbit_inclination);
%valid_flag = Judge_whether_is_valid_range(Sat_Phase,Min_phase,Max_phase);
Accessed_sats = zeros(size(Sats_Raan_Phase,1),1);
count = 0;

for k = 1:size(Sats_Raan_Phase,1)
    Sat_Raan = Sats_Raan_Phase(k,2);
    Sat_Phase = Sats_Raan_Phase(k,3);
  
    [coverage_flag,~,~] = calcluate_Access_area(Sat_Raan,Sat_Phase,Target_latitude,Target_longitude,orbit_inclination,Alpha_D);
    %coverage_flag = calcluate_Access_area_V2(Sat_Raan,Sat_Phase,Target_latitude,Target_longitude,orbit_inclination,Alpha_D);   
    if coverage_flag
        count = count + 1;
        Accessed_sats(count,1) = Sats_Raan_Phase(k,1);
    end

end
Accessed_sats = Accessed_sats(1:count,:);


%output
output_Accessed_sats = Accessed_sats;
end

