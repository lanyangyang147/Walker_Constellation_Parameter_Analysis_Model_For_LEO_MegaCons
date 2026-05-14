function [output_MIN_fold,output_MAX_fold,output_AVG_fold] = gene_coverage_fold_result(Facility_coverage_folds)
%GENE_COVERAGE_FOLD_RESULT 此处显示有关此函数的摘要
%   此处显示详细说明
coverage_folds = zeros(size(Facility_coverage_folds,1),1);

for k = 1:size(Facility_coverage_folds,1)
    coverage_folds(k,1) = Facility_coverage_folds{k,2};
end

MIN_fold = min(coverage_folds);
MAX_fold = max(coverage_folds);
AVG_fold = mean(coverage_folds);
%output
output_MIN_fold = MIN_fold;
output_MAX_fold = MAX_fold;
output_AVG_fold = AVG_fold;
end

