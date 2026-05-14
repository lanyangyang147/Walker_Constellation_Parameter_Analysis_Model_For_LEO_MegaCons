function [output_Accuracy] = Calaulate_Prediction_accuracy(STK_CoverageFolds,Map2D_CoverageFolds)
%CALAULATE_PREDICTION_ACCURACY 此处显示有关此函数的摘要
%   此处显示详细说明


Accuracy = (1 - abs(STK_CoverageFolds - Map2D_CoverageFolds) / STK_CoverageFolds)* 100;


%output
output_Accuracy = Accuracy;
end

