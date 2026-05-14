function [output_Model_accuracy_STK_AND_Proposed,output_Avg_Access_accuracy,output_Avg_Range_accuracy] = Calc_accuracy_for_ISL(Model_accuracy_STK_AND_Proposed)
%CALC_ACCURACY_FOR_ISL 此处显示有关此函数的摘要
%   此处显示详细说明

Sum_Access_accuracy = 0;
Sum_Range_accuracy = 0;
for k = 1:size(Model_accuracy_STK_AND_Proposed,1)
    tmp_Res = Model_accuracy_STK_AND_Proposed{k,2};
    [Access_accuracy,Range_accuracy] = Calculate_model_accuracy_for_ISL(tmp_Res);
        %unit:%
    Sum_Access_accuracy = Sum_Access_accuracy + Access_accuracy;
    Sum_Range_accuracy = Sum_Range_accuracy + Range_accuracy;
    %-----storage----
    Model_accuracy_STK_AND_Proposed{k,3} = Access_accuracy;
    Model_accuracy_STK_AND_Proposed{k,4} = Range_accuracy;
end
Avg_Access_accuracy = Sum_Access_accuracy/size(Model_accuracy_STK_AND_Proposed,1);
Avg_Range_accuracy = Sum_Range_accuracy/size(Model_accuracy_STK_AND_Proposed,1);
%output
output_Model_accuracy_STK_AND_Proposed = Model_accuracy_STK_AND_Proposed;
output_Avg_Access_accuracy = Avg_Access_accuracy;
output_Avg_Range_accuracy = Avg_Range_accuracy;
end

