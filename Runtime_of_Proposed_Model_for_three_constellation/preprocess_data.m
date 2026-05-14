function [output_Starlink_data] = preprocess_data(Starlink_Source_data)
%PREPROCESS_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(Starlink_Source_data);
Starlink_data = zeros(row,column);
 
for m = 1:row
    for n = 1:column
        if ismissing(Starlink_Source_data{m,n})
            Starlink_data(m,n) = 0;
        else
            Starlink_data(m,n) = Starlink_Source_data{m,n};
        end
    end
end
%output
output_Starlink_data = Starlink_data;
end

