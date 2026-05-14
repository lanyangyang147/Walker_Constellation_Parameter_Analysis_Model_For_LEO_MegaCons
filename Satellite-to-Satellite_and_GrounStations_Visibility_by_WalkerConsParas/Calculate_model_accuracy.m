function [output_Access_accuracy,output_Elevation_accuracy,output_Range_accuracy] = Calculate_model_accuracy(Result)
%CALCULATE_MODEL_ACCURACY 此处显示有关此函数的摘要
%   此处显示详细说明
Access_column = 2;
Elevation_column = 3;
Range_column = 4;
%----------Access-------------
Access_Res = [Result(:,Access_column) Result(:,Access_column + 3)];
Proposed_Access_count = 0;
STK_Access_count = 0;
for k = 1:size(Access_Res,1)
    if ~isnan(Access_Res(k,1)) 
        Proposed_Access_count = Proposed_Access_count + 1;
    end
    if ~isnan(Access_Res(k,2)) 
        STK_Access_count = STK_Access_count + 1;
    end
end
Access_accuracy = 1- abs(STK_Access_count - Proposed_Access_count)/STK_Access_count;
%----------Elevation-------------
Elevation_Res = [Result(:,Elevation_column) Result(:,Elevation_column + 3)];
Elevation_accuracy = Calculate_single_accuracy(Elevation_Res);
%----------Range-------------
Range_Res = [Result(:,Range_column) Result(:,Range_column + 3)];
Range_accuracy = Calculate_single_accuracy(Range_Res);
%output
output_Access_accuracy = Access_accuracy * 100;%unit:%
output_Elevation_accuracy = Elevation_accuracy * 100;
output_Range_accuracy = Range_accuracy * 100;
end

