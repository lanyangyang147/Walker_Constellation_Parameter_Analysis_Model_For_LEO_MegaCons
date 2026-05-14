function [output_Comparison_result] = modify_access_value(Model_Result,Value,Proposed_Access_column,Column_Step)
%MODIFY_ACCESS_VALUE 此处显示有关此函数的摘要
%   此处显示详细说明
%-----for visibility-----
% Proposed_Access_column = 2;
% Column_Step = 2;
Proposed_Access_Value = Value - 0.5;
STK_Access_Value = Value ;

for k = 1:size(Model_Result,1)
    if ~isnan(Model_Result(k,Proposed_Access_column))
        Model_Result(k,Proposed_Access_column) = Proposed_Access_Value;
    end
    if ~isnan(Model_Result(k,Proposed_Access_column + Column_Step))
        Model_Result(k,Proposed_Access_column + Column_Step) = STK_Access_Value;
    end
end
%output
output_Comparison_result = Model_Result;
end

