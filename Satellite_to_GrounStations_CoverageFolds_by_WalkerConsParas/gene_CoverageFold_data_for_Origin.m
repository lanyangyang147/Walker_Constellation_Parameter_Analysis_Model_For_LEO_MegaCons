function [output_Coverage_Folds_fixedLon_with_diff_Lat] = gene_CoverageFold_data_for_Origin(Map2D_Facility_Sim_coverage_folds)
%GENE_COVERAGEFOLD_DATA_FOR_ORIGIN 此处显示有关此函数的摘要
%   此处显示详细说明
Coverage_Folds_fixedLon_with_diff_Lat = zeros(size(Map2D_Facility_Sim_coverage_folds,1),4);
%column-format:lat + MIN_fold,MAX_fold,AVG_fold
for k = 1:size(Map2D_Facility_Sim_coverage_folds,1)
    Coverage_Folds_fixedLon_with_diff_Lat(k,1) = Map2D_Facility_Sim_coverage_folds{k,2};
    Coverage_Folds_fixedLon_with_diff_Lat(k,2) = Map2D_Facility_Sim_coverage_folds{k,5};
    Coverage_Folds_fixedLon_with_diff_Lat(k,3) = Map2D_Facility_Sim_coverage_folds{k,6};
    Coverage_Folds_fixedLon_with_diff_Lat(k,4) = Map2D_Facility_Sim_coverage_folds{k,7};
end
%output
output_Coverage_Folds_fixedLon_with_diff_Lat = Coverage_Folds_fixedLon_with_diff_Lat;
end

