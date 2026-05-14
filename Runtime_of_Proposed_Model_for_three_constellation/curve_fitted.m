function [output_fit_value,output_fit_gof] = curve_fitted(x,y)
%CURVE_FITTED 此处显示有关此函数的摘要
%   此处显示详细说明

%x = [5 10 20 40];
%y= [1.011728889 2.020011667 4.039944444 8.087880556];

[xData, yData] = prepareCurveData( x, y );

% 设置 fittype 和选项。
ft = fittype( 'poly1' );

% 对数据进行模型拟合。
[fitresult, fit_gof] = fit( xData, yData, ft );

fit_value = coeffvalues(fitresult);


%output
output_fit_value = fit_value;
output_fit_gof = fit_gof;
end

