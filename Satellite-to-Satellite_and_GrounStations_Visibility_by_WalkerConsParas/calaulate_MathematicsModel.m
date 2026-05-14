function [output_Accuracy] = calaulate_MathematicsModel(Accuracy,Intermitent_link_count,link_distance_res)
%CALAULATE_MATHEMATICSMODEL 此处显示有关此函数的摘要
%   此处显示详细说明
link_accuracy = zeros(size(link_distance_res,1),1);
count = 0;
for k = 1:size(link_distance_res,1)
    if link_distance_res(k,end) ~= 0
       count = count + 1;
       link_accuracy(count,1) = link_distance_res(k,end);
    end
end
link_accuracy = link_accuracy(1:count,:);
if Intermitent_link_count == 1
    Accuracy = link_accuracy;
else
    Accuracy = [Accuracy;link_accuracy];
end
%output
output_Accuracy = Accuracy;
end

