function [output_sat_string] = convert_orb_AND_position_to_sat_string(orbit_id,position_id_in_orbit)
%CONVERT_ORB_AND_POSITION_TO_SAT_STRING 此处显示有关此函数的摘要
%   此处显示详细说明
LEO_string = 'LEO';
% for k = 1:size(Sat_orb_AND_position,1) 
%     if Sat_orb_AND_position(k,1) == sat_index
%         orbit_id = Sat_orb_AND_position(k,2);
%         position_id_in_orbit = Sat_orb_AND_position(k,3);
%         break;
%     end
% end
%-----【start from 0】------
orbit_id = orbit_id + 1;
position_id_in_orbit = position_id_in_orbit + 1;


if orbit_id < 10
    orbit_str = ['0' num2str(orbit_id)];
else
    orbit_str = num2str(orbit_id);
end

if position_id_in_orbit < 10
    sat_position_str = ['0' num2str(position_id_in_orbit)];
else
    sat_position_str = num2str(position_id_in_orbit);
end

sat_str = [LEO_string orbit_str sat_position_str];
%output
output_sat_string = sat_str;
end

