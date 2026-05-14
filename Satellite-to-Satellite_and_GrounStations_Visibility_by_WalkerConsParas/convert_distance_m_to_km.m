function [output_link_distance] = convert_distance_m_to_km(link_distance)
%CONVERT_DISTANCE_M_TO_KM 此处显示有关此函数的摘要
%   此处显示详细说明


 for k = 1:size(link_distance,1)
    link_distance(k,2) = link_distance(k,2) / 1000;%unit: m--->> km
 end


%output
output_link_distance = link_distance;
end

