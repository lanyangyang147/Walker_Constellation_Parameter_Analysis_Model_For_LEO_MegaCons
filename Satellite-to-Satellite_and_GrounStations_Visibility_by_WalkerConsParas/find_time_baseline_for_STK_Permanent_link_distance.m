function [output_Processed_Mathematics_distance,output_Processed_STK_distance,output_Processed_Merge_STK_AND_Math_distance] = find_time_baseline_for_STK_Permanent_link_distance(STK_distance,Mathematics_distance)%,orbital_period,STK_distance_interval)
%FIND_TIME_BASELINE_FOR_STK_PERMANENT_LINK_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
Matching_distance = zeros(size(Mathematics_distance,1),4) * nan;
%column-format: Mathematics_distance(row + value) + STK_distance (matching_row + matching value)
Matching_distance(:,1:2) = Mathematics_distance(:,1:2);

[~,Mathematics_extremeValue_all_rows] = findpeaks(Mathematics_distance(:,2));
[~,STK_extremeValue_all_rows] = findpeaks(STK_distance(:,2));

if size(Mathematics_extremeValue_all_rows,1) ~= 1
    Mathematics_extremeValue_row = Mathematics_extremeValue_all_rows(1,1);
else
    Mathematics_extremeValue_row = Mathematics_extremeValue_all_rows;    
end

if size(STK_extremeValue_all_rows,1) ~= 1
    STK_extremeValue_row = STK_extremeValue_all_rows(1,1);
else
    STK_extremeValue_row = STK_extremeValue_all_rows;
end
%-----Upward-----
Matching_distance = filling_the_front_data_based_extremeValue(STK_extremeValue_row,Mathematics_extremeValue_row,STK_distance,Matching_distance);
% source_STK_upward_row = STK_extremeValue_row;
% des_Math_upward_row = Mathematics_extremeValue_row;
% while source_STK_upward_row <= STK_extremeValue_row
%     Matching_distance(des_Math_upward_row,3) = STK_distance(source_STK_upward_row,1);
%     Matching_distance(des_Math_upward_row,4) = STK_distance(source_STK_upward_row,2);
%     %------break--------
%     if source_STK_upward_row == 1 || des_Math_upward_row == 1
%         break;
%     end
%     %------update variable--------
%     source_STK_upward_row = source_STK_upward_row - 1;
%     des_Math_upward_row = des_Math_upward_row - 1;    
% end
%-----Backward-----
Matching_distance = filling_the_back_data_based_extremeValue(STK_extremeValue_row,Mathematics_extremeValue_row,STK_distance,Mathematics_distance,Matching_distance);
% source_STK_backward_row = STK_extremeValue_row + 1;
% des_Math_backward_row = Mathematics_extremeValue_row + 1;
% while source_STK_backward_row <= size(STK_distance,1)
%     Matching_distance(des_Math_backward_row,3) = STK_distance(source_STK_backward_row,1);
%     Matching_distance(des_Math_backward_row,4) = STK_distance(source_STK_backward_row,2);
%     %------break--------
%     if source_STK_backward_row == size(STK_distance,1) || des_Math_backward_row == size(Mathematics_distance,1)
%         break;
%     end
%     %------update variable--------
%     source_STK_backward_row = source_STK_backward_row + 1;
%     des_Math_backward_row = des_Math_backward_row + 1;    
% end

%-----Seperate the data -----
Processed_Mathematics_distance = zeros(size(Mathematics_distance,1),size(Mathematics_distance,2)) * nan;
Processed_STK_distance = zeros(size(STK_distance,1),size(STK_distance,2)) * nan;
Processed_Merge_STK_AND_Math_distance = zeros(size(Mathematics_distance,1),3) * nan;
count = 0;
for k = 1:size(Matching_distance,1)
    tmp_Math_distance = Matching_distance(k,2);
    tmp_STK_distance = Matching_distance(k,end);
    if ~isnan(tmp_Math_distance) && ~isnan(tmp_STK_distance)
       count = count + 1;
       %----Mathematics--------
       Processed_Mathematics_distance(count,:) = Matching_distance(k,1:2);
       %----STK--------
       Processed_STK_distance(count,:) = Matching_distance(k,3:4);
       %----Merge--------
       Processed_Merge_STK_AND_Math_distance(count,1) = Matching_distance(k,1); 
       Processed_Merge_STK_AND_Math_distance(count,2) = Matching_distance(k,2); 
       Processed_Merge_STK_AND_Math_distance(count,3) = Matching_distance(k,4); 
    end
end

Processed_Mathematics_distance = Processed_Mathematics_distance(1:count,:);
Processed_STK_distance = Processed_STK_distance(1:count,:);
Processed_Merge_STK_AND_Math_distance = Processed_Merge_STK_AND_Math_distance(1:count,:);
%output
output_Processed_Mathematics_distance = Processed_Mathematics_distance;
output_Processed_STK_distance = Processed_STK_distance;
output_Processed_Merge_STK_AND_Math_distance = Processed_Merge_STK_AND_Math_distance;
end

