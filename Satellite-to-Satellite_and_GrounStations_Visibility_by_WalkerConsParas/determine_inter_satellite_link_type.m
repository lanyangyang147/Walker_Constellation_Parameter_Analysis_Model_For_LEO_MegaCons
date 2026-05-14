function [outputA_link_type_string] = determine_inter_satellite_link_type(STK_distance,Math_distance,STK_distance_interval)
%DETERMINE_INTER_SATELLITE_LINK_TYPE 此处显示有关此函数的摘要
%   此处显示详细说明

%----Set the link type: permanent or intermittent -
link_type1_str = 'Permanent link'; 
link_type2_str = 'Intermittent link'; 

Intermittent_link_flag_based_STK = 0;
Intermittent_link_flag_based_Math = 0;
%----- Check STK distance data--------
for k = 1:size(STK_distance,1)
    if STK_distance(k,1) ~= (k - 1) * STK_distance_interval
        Intermittent_link_flag_based_STK = 1;
        break;
    end
end
%----- Check Mathematics distance data--------
for k = 1:size(Math_distance,1)
    if Math_distance(k,2) == 0
        Intermittent_link_flag_based_Math = 1;
        break;
    end
end
%---------Judge----------
if Intermittent_link_flag_based_STK && Intermittent_link_flag_based_Math
   link_type_string = link_type2_str;
elseif  ~Intermittent_link_flag_based_STK && ~Intermittent_link_flag_based_Math
    link_type_string = link_type1_str;
else
    error('The type of link type is not consistent!\n');
end
%output
outputA_link_type_string = link_type_string;
end

