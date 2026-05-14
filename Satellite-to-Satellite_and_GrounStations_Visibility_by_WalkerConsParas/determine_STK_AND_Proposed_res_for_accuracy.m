function [output_Proposed_Sats_for_accuracy,output_STK_Sats_for_accuracy] = determine_STK_AND_Proposed_res_for_accuracy(Proposed_Select_Sat_name,Proposed_Select_Sat_Res,STK_Result)
%DETERMINE_STK_AND_PROPOSED_RES_FOR_ACCURACY 此处显示有关此函数的摘要
%   此处显示详细说明
%Select_Sat_name,Proposed_Select_Sat_Res,STK_Result
%-------------STK--------------------
for k = 1:size(STK_Result,1)
    if strcmp(STK_Result{k,1},Proposed_Select_Sat_name)
        STK_Sats_for_accuracy = STK_Result{k,2};
        break;
    end
end
%------------Proposed------------------
[row,column] = size(Proposed_Select_Sat_Res);
Proposed_Sats_for_accuracy = cell(row,column);
count = 0;

for k = 1:size(Proposed_Select_Sat_Res,1)
    sat1_name_str = Proposed_Select_Sat_Res{k,1};
    sat2_name_str = Proposed_Select_Sat_Res{k,2};
    flag = 0;
    for m = 1:size(STK_Sats_for_accuracy,1)
        if contains(STK_Sats_for_accuracy{m,1},sat1_name_str) && contains(STK_Sats_for_accuracy{m,1},sat2_name_str)
            flag = 1;
            break;
        end
    end
    if flag
        count = count + 1;
        Proposed_Sats_for_accuracy(count,:) = Proposed_Select_Sat_Res(k,:);
    end
end
Proposed_Sats_for_accuracy = Proposed_Sats_for_accuracy(1:count,:);
%output
output_Proposed_Sats_for_accuracy = Proposed_Sats_for_accuracy;
output_STK_Sats_for_accuracy = STK_Sats_for_accuracy;
end

