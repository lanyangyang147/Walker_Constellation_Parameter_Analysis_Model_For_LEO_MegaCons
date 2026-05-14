function [output_Sats_for_accuracy] = determine_Sats_for_accuarcy(Sat_Calc_Res,Select_SatNum_for_Calc_Accuracy)
%DETERMINE_SATS_FOR_ACCUARCY 此处显示有关此函数的摘要
%   此处显示详细说明
[row,column] = size(Sat_Calc_Res);
effective_Sat_Calc_Res = cell(row,column);
Sats_data_for_accuracy = cell(Select_SatNum_for_Calc_Accuracy,column);
count = 0;
%------filter the invalid ISL data --------
for k = 1:size(Sat_Calc_Res,1)
    tmp_data = Sat_Calc_Res{k,5};
    if size(tmp_data,1) ~= 1
        count = count + 1;
        effective_Sat_Calc_Res(count,:) = Sat_Calc_Res(k,:);
    end
end
effective_Sat_Calc_Res = effective_Sat_Calc_Res(1:count,:);

Random_generated_Sats = randperm(count)';

for k = 1:Select_SatNum_for_Calc_Accuracy
    Random_row = Random_generated_Sats(k,1);
    Sats_data_for_accuracy(k,:) = effective_Sat_Calc_Res(Random_row,:);
end
%output
output_Sats_for_accuracy = Sats_data_for_accuracy;
end

