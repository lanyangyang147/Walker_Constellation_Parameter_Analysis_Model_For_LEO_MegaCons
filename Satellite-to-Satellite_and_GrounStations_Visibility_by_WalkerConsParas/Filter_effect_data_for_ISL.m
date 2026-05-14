function [output_STK_Result] = Filter_effect_data_for_ISL(Orbital_period,Num_of_Orbital_Period,STK_Result)
%FILTER_EFFECT_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
for k = 1:size(STK_Result,1)
    time = STK_Result(k,1);
    if time >= Orbital_period * Num_of_Orbital_Period
        end_row = k - 1;
        break;
    elseif k == size(STK_Result,1)
        end_row = k;
        break;
    end
end
STK_Result = STK_Result(1:end_row,:);
%column-format:time +elevation_in_value +  distance_in_m

for k = 1:size(STK_Result,1)
    %column2:elevation_value -- > deg
    STK_Result(k,2) = -1 * STK_Result(k,2)/(2*pi)*360;
    %column3:range_in_m-----convert to km
    STK_Result(k,3) = STK_Result(k,3)/1000; 
    %column4:convert to access data
    STK_Result(k,4) = 2; 
end
New_STK_Result = [STK_Result(:,1) STK_Result(:,4) STK_Result(:,2) STK_Result(:,3)];
%output
output_STK_Result = New_STK_Result;
end

