function [output_STK_Result] = Filter_effect_data(Orbital_period,Num_of_Orbital_Period,STK_Result)
%FILTER_EFFECT_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
for k = 1:size(STK_Result,1)
    time = STK_Result(k,1);
    if time >= Orbital_period * Num_of_Orbital_Period
        end_row = k - 1;
        break;
    end
end
STK_Result = STK_Result(1:end_row,:);

for k = 1:size(STK_Result,1)
    %column2:azimuth is useless-----convert to access data
    STK_Result(k,2) = 2;
    %column3:elevation_in_rad-----convert degree
    STK_Result(k,3) = STK_Result(k,3)*180/pi;
    %column4:range_in_m-----convert to km
    STK_Result(k,4) = STK_Result(k,4)/1000;
end
%output
output_STK_Result = STK_Result;
end

