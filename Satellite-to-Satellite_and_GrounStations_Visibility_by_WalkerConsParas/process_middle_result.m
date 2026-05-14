function [output_Access_AND_distance] = process_middle_result(Model_distance_curve)
%PROCESS_MIDDLE_RESULT 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(Model_distance_curve);
 Access_AND_distance = zeros(row,column + 1)*nan;
    %Column-format:time + Access + Disyance_in_km
for k = 1:size(Model_distance_curve,1)
    flag = Model_distance_curve(k,2);
    if flag
       Access_AND_distance(k,2) = 1;
       Access_AND_distance(k,3) = Model_distance_curve(k,2) / 1000;%unit:km
       Access_AND_distance(k,4) = Model_distance_curve(k,3);%unit:elevation_deg
    end
    %----storage-------
    Access_AND_distance(k,1) = Model_distance_curve(k,1);
end
%output
output_Access_AND_distance = Access_AND_distance;
end

