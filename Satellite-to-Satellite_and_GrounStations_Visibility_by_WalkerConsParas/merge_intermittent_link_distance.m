function [output_Intermittent_link_res] = merge_intermittent_link_distance(link_distance_res,Intermittent_link_res,Intermitent_link_count)
%INTERMITTENT_LINK_RES 此处显示有关此函数的摘要
%   此处显示详细说明
Entire_distance_res = Intermittent_link_res(:,1);
% fill it
for k = 1:size(Entire_distance_res,1)
    tmp_phase = Entire_distance_res(k,1);
    [flag,des_row] = find_valid_distance_data(tmp_phase,link_distance_res);
    if flag 
       Entire_distance_res(k,2) = link_distance_res(des_row,2);
       Entire_distance_res(k,3) = link_distance_res(des_row,3);
    else
       Entire_distance_res(k,2) = nan;
       Entire_distance_res(k,3) = nan;      
    end
end
%----merge it----  
if Intermitent_link_count == 1
    Intermittent_link_res = Entire_distance_res;
else
    Intermittent_link_res = [Intermittent_link_res Entire_distance_res(:,2:3)];
end
%output
output_Intermittent_link_res = Intermittent_link_res;
end


