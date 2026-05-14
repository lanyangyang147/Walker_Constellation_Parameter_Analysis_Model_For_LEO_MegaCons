function [output_STK_Sats_for_ISL_data] = determine_STK_Sats_for_ISL_data(Proposed_Result)
%DETERMINE_STK_SATS_FOR_ISL_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
%---------Extract the random Sat to generate ISL data------------- 
Sum_of_column = size(Proposed_Result,2);

All_the_random_selected_sats = Proposed_Result{1,Sum_of_column - 1};

STK_Sats_for_ISL_data = All_the_random_selected_sats(:,1);

%output
output_STK_Sats_for_ISL_data = STK_Sats_for_ISL_data;
end

