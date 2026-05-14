function [output_ISL_Distance_Data] = Find_ISL_Distance_data(StarLink_sat_link_Access)
%FIND_ISL_DISTANCE_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
Time_Column = 6;
Range_Column = 9;

ISL_Distance_Data = cell(size(StarLink_sat_link_Access,1),3);
%Column-Format: Access-name + Time + Range
ISL_Distance_Data(:,1) = StarLink_sat_link_Access(:,1);

ISL_Distance_Data(:,2) = StarLink_sat_link_Access(:,Time_Column);
ISL_Distance_Data(:,3) = StarLink_sat_link_Access(:,Range_Column);



%output
output_ISL_Distance_Data = ISL_Distance_Data;
end

