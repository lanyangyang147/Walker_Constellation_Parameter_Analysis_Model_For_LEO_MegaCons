function [output_STK_distance_curve] = Filter_effect_link_distance(STK_Init_distance_curve,maximum_link_distance_in_km)
%FILTER_EFFECT_LINK_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
maximum_link_distance_in_m = maximum_link_distance_in_km * 1000;

Invalid_count = 0;
for k = 1:size(STK_Init_distance_curve,1)
    tmp_distance = STK_Init_distance_curve(k,2);
    if tmp_distance > maximum_link_distance_in_m
        Invalid_count = Invalid_count + 1;
    end
end

if Invalid_count == size(STK_Init_distance_curve,1)
    STK_distance_curve = nan;
else
    STK_distance_curve = zeros(size(STK_Init_distance_curve,1),size(STK_Init_distance_curve,2));
    effect_count = 0;

    for k = 1:size(STK_Init_distance_curve,1)
        tmp_distance = STK_Init_distance_curve(k,2);
        if tmp_distance <= maximum_link_distance_in_m
            effect_count = effect_count + 1;
            STK_distance_curve(effect_count,:) = STK_Init_distance_curve(k,:);
        end
    end
    STK_distance_curve = STK_distance_curve(1:effect_count,:);
end
%output
output_STK_distance_curve = STK_distance_curve;
end

