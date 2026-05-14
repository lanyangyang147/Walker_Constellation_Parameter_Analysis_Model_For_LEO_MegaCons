function [outputA_Model_accuracy_STK_AND_Proposed] = Merge_Proposed_AND_STK_Calc_Result(Proposed_Calc_Result,STK_Calc_Result)
%MERGE_PROPOSED_AND_STK_CALC_RESULT 此处显示有关此函数的摘要
%   此处显示详细说明

% Proposed_Calc_Result = ISL_Access_AND_distance_data;
% STK_Calc_Result = STK_result;

Model_accuracy_STK_AND_Proposed = cell(size(Proposed_Calc_Result,1),4);
%column:ISL Name + data(STK+proposed) + accuracy(access +  range)
for k = 1:size(Proposed_Calc_Result,1)
    tmp_Sat_name_str = Proposed_Calc_Result{k,2};
    tmp_proposed_res = Proposed_Calc_Result{k,5};
        %Column-format: time + Access + elevation_in_deg + range_in_km
    corresponding_row = find_STK_calculated_res(tmp_Sat_name_str,STK_Calc_Result);
    tmp_STK_res = STK_Calc_Result{corresponding_row,2};
        %Column-format: time+ access + elevation_in_deg + range_in_km
    Row_STK_AND_Proposed_Res = Matching_calculated_result(tmp_proposed_res,tmp_STK_res);
    %------storage-----
    Model_accuracy_STK_AND_Proposed{k,1} = STK_Calc_Result{corresponding_row,1};
    Model_accuracy_STK_AND_Proposed{k,2} = Row_STK_AND_Proposed_Res;
end
%output
outputA_Model_accuracy_STK_AND_Proposed = Model_accuracy_STK_AND_Proposed;
end

