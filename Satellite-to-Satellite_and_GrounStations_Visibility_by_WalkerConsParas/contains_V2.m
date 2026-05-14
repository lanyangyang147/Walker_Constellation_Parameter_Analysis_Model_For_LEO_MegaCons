function [output_True_or_False] = contains_V2(string,patttern)
%CONTAINS 此处显示有关此函数的摘要
%   此处显示详细说明

TMP = strfind(string,patttern);

if isempty(TMP)
    True_or_False = 0;
else
    True_or_False = 1;
end
%output
output_True_or_False = True_or_False;
end

