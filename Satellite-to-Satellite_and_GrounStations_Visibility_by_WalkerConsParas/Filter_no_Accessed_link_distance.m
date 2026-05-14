function [output_Model_distance_curve] = Filter_no_Accessed_link_distance(Model_Init_distance_curve)
%FILTER_NO_ACCESSED_LINK_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
Sum_of_row = size(Model_Init_distance_curve,1);
Invalid_count = 0;
for k = 1:size(Model_Init_distance_curve,1)
    tmp_distance = Model_Init_distance_curve(k,2);
    if isnan(tmp_distance)
        Invalid_count = Invalid_count + 1;
    end
end

if Invalid_count == Sum_of_row
    Model_distance_curve = nan;
else
    for k = 1:size(Model_Init_distance_curve,1)
        tmp_distance = Model_Init_distance_curve(k,2);
        if isnan(tmp_distance)
            Model_Init_distance_curve(k,2) = 0;
            Model_Init_distance_curve(k,3) = 0;
        end
    end

    Model_distance_curve = Model_Init_distance_curve;
end

%output
output_Model_distance_curve = Model_distance_curve;
end





