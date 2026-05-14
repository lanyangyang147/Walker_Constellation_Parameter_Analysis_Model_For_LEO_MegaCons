function [output_STK_Result] = Filter_effect_STK_data_for_ISL(STK_Result)
%FILTER_EFFECT_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
% for k = 1:size(STK_Result,1)
%     time = STK_Result(k,1);
%     if time >= Sum_of_Calculate_Time%Orbital_period * Num_of_Orbital_Period
%         end_row = k - 1;
%         break;
%     end
% end
% STK_Result = STK_Result(1:end_row,:);
%column-format:time + distance_in_m

for k = 1:size(STK_Result,1)
    %column2:range_in_m-----convert to km
    STK_Result(k,2) = STK_Result(k,2)/1000;
    %column3:convert to access data
    STK_Result(k,3) = 2;
end
New_STK_Result = [STK_Result(:,1) STK_Result(:,3) STK_Result(:,2)];
%output
output_STK_Result = New_STK_Result;
end

