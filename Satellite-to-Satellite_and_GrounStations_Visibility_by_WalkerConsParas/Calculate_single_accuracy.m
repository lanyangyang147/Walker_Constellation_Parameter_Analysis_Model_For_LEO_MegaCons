function [outputArg2_Accuracy] = Calculate_single_accuracy(Result)
%CALCULATE_SINGLE_ACCURACY 此处显示有关此函数的摘要
%   此处显示详细说明
Row_accuracy = zeros(size(Result,1),1);
count = 0;
for k = 1:size(Result,1)
    Propoesd_Res = Result(k,1);
    STK_Res = Result(k,2);
    if isnan(Propoesd_Res) && isnan(STK_Res)
        %--nothing----
    elseif ~isnan(Propoesd_Res) && ~isnan(STK_Res)
        %--two values---
        count = count + 1; 
        tmp_accuracy = 1- abs(Propoesd_Res - STK_Res)/STK_Res;
        Row_accuracy(count,1) = tmp_accuracy;
    else
       %---one values----
        count = count + 1; 
        Row_accuracy(count,1) = 0;       
    end
end
Row_accuracy = Row_accuracy(1:count,:);
Accuracy = mean(Row_accuracy(:,1));
%
outputArg2_Accuracy = Accuracy;
end

