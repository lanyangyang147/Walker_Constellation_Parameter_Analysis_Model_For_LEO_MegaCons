function [output_Permanent_link_res] = merge_permanent_link_distance(distance_res,Permanent_link_res,Permanent_link_count)
%MERGE_PERMANENT_LINK_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
%distance_res = Valid_ISLs_distance_data{row,Res_column};
    %column-format:phase  + STK + Mathematics
Entire_distance_res = Permanent_link_res(:,1);
% fill it
for k = 1:size(Entire_distance_res,1)
    tmp_phase = Entire_distance_res(k,1);
    [flag,des_row] = find_valid_distance_data(tmp_phase,distance_res);
    if flag 
       Entire_distance_res(k,2) = distance_res(des_row,2);
       Entire_distance_res(k,3) = distance_res(des_row,3);
    else
       Entire_distance_res(k,2) = nan;
       Entire_distance_res(k,3) = nan;      
    end
end
%----merge it----  
if Permanent_link_count == 1
    Permanent_link_res = Entire_distance_res;
else
    Permanent_link_res = [Permanent_link_res Entire_distance_res(:,2:3)];
end
%output
output_Permanent_link_res = Permanent_link_res;
end

