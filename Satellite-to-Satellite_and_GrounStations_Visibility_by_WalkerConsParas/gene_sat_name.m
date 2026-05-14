function [output_Sat_name_str] = gene_sat_name(orbit_num,orbit_sat_num)
%GENE_SAT_NAME 此处显示有关此函数的摘要
%   此处显示详细说明
LEO_str = 'LEO';
if orbit_num < 10
   orbit_str = ['0' num2str(orbit_num)];
else
   orbit_str = num2str(orbit_num);
end
if orbit_sat_num < 10
   orbit_sat_str = ['0' num2str(orbit_sat_num)];
else
   orbit_sat_str = num2str(orbit_sat_num);
end

Sat_name_str = [LEO_str orbit_str orbit_sat_str];
%output
output_Sat_name_str = Sat_name_str;
end

