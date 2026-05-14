function [out_Valid_flag] = Whether_Elevation_is_valid(GS_Min_Elevation,Elevation)
%WHETHER_ELEVATION_IS_VALID 此处显示有关此函数的摘要
%   此处显示详细说明
%Valid_elevation_range: 90-180
Min_elevation = GS_Min_Elevation;
Max_elevation = pi/2;
if Elevation >= Min_elevation && Elevation <= Max_elevation
    Valid_flag = 1;
else
    Valid_flag = 0;
end
%output
out_Valid_flag = Valid_flag;
end

