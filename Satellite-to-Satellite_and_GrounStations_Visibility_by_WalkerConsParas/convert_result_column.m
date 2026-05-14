function [output_Reverse_link_distance_res] = convert_result_column(link_distance_res)
%CONVERT_RESULT_COLUMN 此处显示有关此函数的摘要
%   此处显示详细说明
%column-format:phase + Mathematics + STK -【convert to】--phase +  STK + Mathematics
Reverse_link_distance_res = zeros(size(link_distance_res,1),size(link_distance_res,2));
Reverse_link_distance_res(:,1) = link_distance_res(:,1);
for k = 1:size(link_distance_res,1)
    Reverse_link_distance_res(k,2) = link_distance_res(k,3);
    Reverse_link_distance_res(k,3) = link_distance_res(k,2);
end
%output
output_Reverse_link_distance_res = Reverse_link_distance_res;
end

