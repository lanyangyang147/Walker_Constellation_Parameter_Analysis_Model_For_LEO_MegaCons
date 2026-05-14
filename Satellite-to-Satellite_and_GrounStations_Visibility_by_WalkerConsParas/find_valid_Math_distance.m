function [output_Math_distance] = find_valid_Math_distance(column,Seperated_Math_distance)
%FIND_VALID_MATH_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
for k = 1:size(Seperated_Math_distance,1)
    if Seperated_Math_distance(k,column) == 0
        end_row = k - 1;
        break;
    elseif k == size(Seperated_Math_distance,1)
        end_row = k;
    end
end
 Math_distance = Seperated_Math_distance(1:end_row,column - 1:column);
%output
output_Math_distance = Math_distance;
end

