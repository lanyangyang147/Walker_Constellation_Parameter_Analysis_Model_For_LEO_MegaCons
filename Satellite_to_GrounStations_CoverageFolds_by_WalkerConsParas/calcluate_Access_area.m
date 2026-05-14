function [output_coverage_flag,output_Condition1,output_Condition2] = calcluate_Access_area(Raan,Phase,Target_latitude,Target_longitude,orbit_inclination,Alpha_D)
%CALCLUATE_ACCESS_AREA 此处显示有关此函数的摘要
%   此处显示详细说明

common_part1 = Raan - Target_longitude + arctan2(cos(orbit_inclination) * sin(Phase),cos(Phase));

element1 = cos(Alpha_D) - sin(Target_latitude) * sin(orbit_inclination) * sin(Phase);
element2 = cos(Target_latitude) * sqrt(1 - (sin(orbit_inclination) * sin(Phase))^2);
common_part2 = acos(element1/element2);

Condition1 = common_part1 + common_part2;
Condition2 = common_part1 - common_part2;
%-------for debug-----start-------
%[Min_phase,Max_phase] = Calculate_phase_range(Target_latitude,Alpha_D,orbit_inclination);
%valid_flag = Judge_whether_is_valid_range(Phase,Min_phase,Max_phase);
%-------for debug-----end-------
if Condition1 >=0 && Condition2 <= 0
    coverage_flag = 1;
else
    coverage_flag = 0;
end

%output
output_coverage_flag = coverage_flag;
output_Condition1 = Condition1;
output_Condition2 = Condition2;
end

