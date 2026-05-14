function [output_value] = arctan2(y,x)
%ARCTAN2 此处显示有关此函数的摘要
%   此处显示详细说明
if x >= 0
    value = atan(y/x);
else
    value = atan(y/x) + pi;
end
%output
output_value = value;
end

