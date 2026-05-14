function [output_MIN_fold,output_MAX_fold,output_AVG_fold] = find_coverage_fold_based_on_latitude(Latitude,STK_CoverageFolds_Res)
%FIND_COVERAGE_FOLD_BASED_ON_LATITUDE 此处显示有关此函数的摘要
%   此处显示详细说明
for k = 1:size(STK_CoverageFolds_Res,1)
    if STK_CoverageFolds_Res(k,1) == Latitude
        MIN_fold = STK_CoverageFolds_Res(k,2);
        MAX_fold = STK_CoverageFolds_Res(k,3);
        AVG_fold = STK_CoverageFolds_Res(k,4);
        break;
    end
end
%output
output_MIN_fold = MIN_fold;
output_MAX_fold = MAX_fold;
output_AVG_fold = AVG_fold;
end

