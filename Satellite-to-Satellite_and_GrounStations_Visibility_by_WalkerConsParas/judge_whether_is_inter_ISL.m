function [output_flag] = judge_whether_is_inter_ISL(source_sat_row,des_sat_row,objNames)
%JUDGE_WHETHER_NEED_CALC fun:judge_whether_need_calc
source_sat_str = objNames{source_sat_row,1};
des_sat_str = objNames{des_sat_row,1};

source_sat_orbit = str2double(source_sat_str(end - 3:end - 2));
des_sat_orbit = str2double(des_sat_str(end - 3:end - 2));

if source_sat_orbit == des_sat_orbit 
   flag = 0; 
else
   flag = 1; 
end

%out put 
output_flag = flag;
end

