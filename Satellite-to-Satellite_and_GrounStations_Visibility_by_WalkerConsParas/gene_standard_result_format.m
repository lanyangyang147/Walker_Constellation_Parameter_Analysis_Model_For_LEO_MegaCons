function [output_Permanent_link_res] = gene_standard_result_format(start_phase,end_phase)
%GENE_STANDARD_RESULT_FORMAT 此处显示有关此函数的摘要
%   此处显示详细说明

Sum_of_row = end_phase - start_phase + 1;
Permanent_link_res = zeros(Sum_of_row,3) * nan;
    %column-format:phase + STK + Mathematics
count = 0;
for k = start_phase:end_phase
    count = count + 1;
    Permanent_link_res(k,1) = k - 1;
end
%output
output_Permanent_link_res = Permanent_link_res;
end

