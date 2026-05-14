function [output_STK_Sats_for_ISL_data] = Find_STK_Sats_for_ISL_data(Select_SatNum_for_Calc_Accuracy,Proposed_model_Calc_Result)
%FIND_STK_SATS_FOR_ISL_DATA 此处显示有关此函数的摘要
%   此处显示详细说明
column = size(Proposed_model_Calc_Result,2);
Proposed_Calc_Result = Proposed_model_Calc_Result{1,column - 1};

STK_Sats_for_ISL_data = cell(size(Proposed_Calc_Result,1),size(Proposed_Calc_Result,2));

for m = 1:size(Proposed_Calc_Result,1)
    Tmp_Sat_Calc_Res = Proposed_Calc_Result{m,2};
    Sats_for_accuracy = determine_Sats_for_accuarcy(Tmp_Sat_Calc_Res,Select_SatNum_for_Calc_Accuracy);
    %STK_Sats_for_accuracy = find_corresponding_STK_Sats_data(Sats_for_accuracy,STK_Result);
    %-------storage-------
    STK_Sats_for_ISL_data{m,1} = Proposed_Calc_Result{m,1};
    STK_Sats_for_ISL_data{m,2} = Sats_for_accuracy;
end
%output
output_STK_Sats_for_ISL_data = STK_Sats_for_ISL_data;
end

