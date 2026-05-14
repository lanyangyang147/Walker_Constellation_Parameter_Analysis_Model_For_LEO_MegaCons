function [output_predictable_runtime] = calc_predicatable_runtime(Sum_Sats_in_Starlink,fit_value)
%CALC_PREDICATABLE_RUNTIME 此处显示有关此函数的摘要
%   此处显示详细说明
predictable_runtime = 0;
coefficient_count = -1; 

for column = size(fit_value,2):-1:1
    coefficient_count = coefficient_count + 1;
    tmp_fit_para = fit_value(1,column);
    predictable_runtime = predictable_runtime + tmp_fit_para * Sum_Sats_in_Starlink^coefficient_count;
end
%output
output_predictable_runtime = predictable_runtime;
end

