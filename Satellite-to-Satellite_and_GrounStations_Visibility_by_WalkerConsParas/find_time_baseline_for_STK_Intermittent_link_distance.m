function [output_Processed_Mathematics_distance,output_Processed_STK_distance,output_Processed_Merge_STK_AND_Math_distance] = find_time_baseline_for_STK_Intermittent_link_distance(STK_distance,Mathematics_distance,STK_distance_interval,orbital_period)
%FIND_TIME_BASELINE_FOR_STK_INTERMITTENT_LINK_DISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
%2 * pi = Angle_velocity * orbital_period;
%Angle_velocity = 360 / orbital_period;%unit:rad

%STK_distance,Mathematics_distance,STK_distance_interval,orbital_period
%-------- 1. Seperate the segment Access data-----------
%----STK---------
Seperated_STK_distance = zeros(1,1);
column = -1;
Segment_start_row = 1;
while Segment_start_row <= size(STK_distance,1)
    Segment_end_row = find_Segment_Access_end_row(Segment_start_row,STK_distance_interval,STK_distance);
    %---------Storage-------
    column = column + 2;
    Seperated_STK_distance = find_Segement_Accessed_distance(Segment_end_row,Segment_start_row,column,Seperated_STK_distance,STK_distance);
    %---------Break-------
    if Segment_end_row == size(STK_distance,1)
        break;
    end
    %---------Update-------
    Segment_start_row = Segment_end_row + 1;
end
%----Mathematics---------
Seperated_Math_distance = zeros(1,1);
column = -1;
init_start_row = 0;
Segment_start_row = find_Segment_Access_start_row_based_MathModel(init_start_row + 1,Mathematics_distance);
while Segment_start_row < size(Mathematics_distance,1)
    Segment_end_row = find_Segment_Access_end_row_based_MathModel(Segment_start_row,Mathematics_distance);
    %---------Storage-------
    column = column + 2;
    Seperated_Math_distance = find_Segement_Accessed_distance(Segment_end_row,Segment_start_row,column,Seperated_Math_distance,Mathematics_distance);
    %---------Break-------
    if Segment_end_row == size(Mathematics_distance,1)
        break;
    end
    %---------Update-------
    Segment_start_row = find_Segment_Access_start_row_based_MathModel(Segment_end_row + 1,Mathematics_distance);
end
%--2. find the minimum extreme value from segment Access data 【based on Mathematics_distance】 -----------
All_Mathematics_AND_STK_distance = zeros(size(Mathematics_distance,1),4) * nan;
%Column-format:phase + distance(Mathematics) + time + distance ( STK )  
All_Mathematics_AND_STK_distance(:,1:2) = Mathematics_distance(:,1:2);
for column = 2:2:size(Seperated_Math_distance,2)
    %------find the extreme value (and row)----------------------
    tmp_Math_distance = find_valid_Math_distance(column,Seperated_Math_distance);
    tmp_STK_distance = find_valid_Math_distance(column,Seperated_STK_distance);
    %Condition: finding the extreme value must satisfy 3 sampling values
    if size(tmp_Math_distance,1) < 3 && size(tmp_STK_distance,1) < 3
        Math_extreme_min_value = [];
        STK_extreme_min_value = [];
    else
        [Math_extreme_min_value,~] = findpeaks(-tmp_Math_distance(:,2));
        [STK_extreme_min_value,~] = findpeaks(-tmp_STK_distance(:,2));
    end
    if isempty(Math_extreme_min_value) && isempty(STK_extreme_min_value)
        %-------only has minimum value------------
        Math_min_value = min(tmp_Math_distance(:,2));
        STK_min_value = min(tmp_STK_distance(:,2));

        [Math_min_value_start_row,Math_min_value_end_row] = find_min_value_corresponding_row_based_MathematicsModel(Math_min_value,tmp_Math_distance,Mathematics_distance);
        [STK_min_value_start_row,STK_min_value_end_row] = find_min_value_corresponding_row(STK_min_value,tmp_STK_distance,STK_distance_interval,STK_distance);

        %------fill the data based the extreme value----------------------
        if Math_min_value_start_row == 1 && STK_min_value_start_row == 1
            %---back----
            All_Mathematics_AND_STK_distance = filling_back_data_based_MinValue_for_intermittentLink(STK_min_value_start_row,Math_min_value_start_row,STK_distance,Mathematics_distance,STK_min_value_end_row,Math_min_value_end_row,All_Mathematics_AND_STK_distance);
        elseif Math_min_value_end_row == size(Mathematics_distance,1) && STK_min_value_end_row == size(STK_distance,1)
            %---front---
            All_Mathematics_AND_STK_distance = filling_front_data_based_extremeValue_for_intermittentLink(STK_min_value_end_row,Math_min_value_end_row,STK_distance,STK_min_value_start_row,Math_min_value_start_row,All_Mathematics_AND_STK_distance);
        else
            error('Segment link Accesse is other type!\n');
        end
    else
        % find the min extreme value from Segment link Accessed corresponding row----  
        STK_extreme_min_row = determine_row_based_value(-STK_extreme_min_value,STK_distance);
        Math_extreme_min_row = determine_row_based_value(-Math_extreme_min_value,Mathematics_distance);
        % find the start row of Segment link Accessed ---
        STK_extreme_min_start_row = find_Segment_Access_start_row_based_STK(STK_extreme_min_row,STK_distance_interval,STK_distance);
        Math_extreme_min_start_row = find_Segment_link_Access_start_row_MathModel(Math_extreme_min_row,Mathematics_distance);
    
        STK_extreme_min_end_row = find_Segment_Access_end_row(STK_extreme_min_row,STK_distance_interval,STK_distance);
        Math_extreme_min_end_row = find_Segment_Access_end_row_based_MathModel(Math_extreme_min_row,Mathematics_distance);
        %------fill the data based the extreme value----------------------
        %---front---
        All_Mathematics_AND_STK_distance = filling_front_data_based_extremeValue_for_intermittentLink(STK_extreme_min_row,Math_extreme_min_row,STK_distance,STK_extreme_min_start_row,Math_extreme_min_start_row,All_Mathematics_AND_STK_distance);
        %---back----
        All_Mathematics_AND_STK_distance = filling_back_data_based_extremeValue_for_intermittentLink(STK_extreme_min_row,Math_extreme_min_row,STK_distance,Mathematics_distance,STK_extreme_min_end_row,Math_extreme_min_end_row,All_Mathematics_AND_STK_distance);
    end
end
%-----3.Seperate the data -----
Processed_Mathematics_distance = zeros(size(Mathematics_distance,1),size(Mathematics_distance,2));
Processed_STK_distance = zeros(size(Mathematics_distance,1),size(Mathematics_distance,2));
Processed_Merge_STK_AND_Math_distance = zeros(size(Mathematics_distance,1),3) * nan;
%Column-format: phase + STK distance + Mathematics distance
count = 0;
for k = 1:size(All_Mathematics_AND_STK_distance,1)
    tmp_Math_distance = All_Mathematics_AND_STK_distance(k,2);
    tmp_STK_distance = All_Mathematics_AND_STK_distance(k,4);
    
    if tmp_Math_distance == 0 && isnan(tmp_STK_distance)
       %----- No Link Accesss-------- 
       count = count + 1;
       %----Mathematics--------
       Processed_Mathematics_distance(count,1) = All_Mathematics_AND_STK_distance(k,1);
       Processed_Mathematics_distance(count,2) = nan;
       %----STK--------
       Processed_STK_distance(count,1) = All_Mathematics_AND_STK_distance(k,1);
       Processed_STK_distance(count,2) = nan;
       %-----Merge-----
       Processed_Merge_STK_AND_Math_distance(count,1) = All_Mathematics_AND_STK_distance(k,1);
    elseif tmp_Math_distance ~= 0 && ~isnan(tmp_STK_distance)
       %-----Exist Link Accesss-------- 
       count = count + 1;
       %----Mathematics--------
       Processed_Mathematics_distance(count,1) = All_Mathematics_AND_STK_distance(k,1);
       Processed_Mathematics_distance(count,2) = All_Mathematics_AND_STK_distance(k,2);
       %----STK--------
       Processed_STK_distance(count,1) = All_Mathematics_AND_STK_distance(k,1);
       Processed_STK_distance(count,2) = All_Mathematics_AND_STK_distance(k,4);
       %-----Merge-----
       Processed_Merge_STK_AND_Math_distance(count,1) = All_Mathematics_AND_STK_distance(k,1); 
       Processed_Merge_STK_AND_Math_distance(count,2) = All_Mathematics_AND_STK_distance(k,2); 
       Processed_Merge_STK_AND_Math_distance(count,3) = All_Mathematics_AND_STK_distance(k,4); 
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

