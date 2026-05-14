function [output_CoverageFold] = read_coverageFold_res_file(file_name)
%READ_COVERAGEFOLD_RES_FILE 此处显示有关此函数的摘要
%   此处显示详细说明
%CoverageFold = read_coverageFold_res_file(file_name);

init_data = readcell(file_name);
% latitude_start = 0;
% latitude_end = 60;
CoverageFold = zeros(size(init_data,1),2);
%column-format: latitude + coveragefold
count = 0;
for k = 1:size(init_data,1)
    tmp_data = init_data{k,1};
    if ~ischar(tmp_data) 
        count = count + 1;
        CoverageFold(count,1) = tmp_data;
        CoverageFold(count,2) = init_data{k,2};
    end
end
CoverageFold = CoverageFold(1:count,:);
%output
output_CoverageFold = CoverageFold;
end

