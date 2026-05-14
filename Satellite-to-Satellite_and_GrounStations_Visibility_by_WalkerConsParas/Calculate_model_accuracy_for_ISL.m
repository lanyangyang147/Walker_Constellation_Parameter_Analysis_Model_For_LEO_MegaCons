function [output_Avg_Access_accuracy,output_Avg_Elevation_accuracy,output_Avg_Distance_accuracy,output_ISL_PropoedModel_AND_STK_accuracy] = Calculate_model_accuracy_for_ISL(Result)
%CALCULATE_MODEL_ACCURACY 此处显示有关此函数的摘要
%   此处显示详细说明
Proposed_Access_column = 2;
Proposed_elevation_column = 3;
Proposed_distance_column = 4;
Duration_column = 3;
%---------------Access accuracy-------------------
Row = 1;
Access_Segment = 0;
Access_accuracy = zeros(1,1);
while Row < size(Result,1)
    [ProposedModel_StartRow,ProposedModel_EndRow] = find_Access_Segment_info(Row,Result,Proposed_Access_column);
    [STK_StartRow,STK_EndRow] = find_Access_Segment_info(Row,Result,Proposed_Access_column + Duration_column);
    if ProposedModel_StartRow == size(Result,1) || ProposedModel_EndRow == size(Result,1) || STK_StartRow == size(Result,1) || STK_EndRow == size(Result,1)
        break;
    end
    %------------ visibility accuracy-------------
    Proposed_Access_Segment_duration = ProposedModel_EndRow - ProposedModel_StartRow + 1;
    STK_Access_Segment_duration = STK_EndRow - STK_StartRow + 1;
    Segment_Access_accuracy = 1- abs(STK_Access_Segment_duration - Proposed_Access_Segment_duration)/STK_Access_Segment_duration;
    %------storage--------
    Access_Segment = Access_Segment + 1;
    Access_accuracy(Access_Segment,1) = Segment_Access_accuracy;
    %----update------
    Row = max(ProposedModel_EndRow,STK_EndRow) + 1;
end
Access_accuracy= Access_accuracy(1:Access_Segment,1);
Avg_Access_accuracy = mean(Access_accuracy);
%---------------elevation + distance accuracy-------------------
Sum_Elevation_accuracy = 0;
Sum_Distance_accuracy = 0;
Elevation_count = 0;
Distance_count = 0;

for k = 1:size(Result,1)
    Proposed_elevation = Result(k,Proposed_elevation_column);
    Proposed_distance = Result(k,Proposed_distance_column);
    STK_elevation = Result(k,Proposed_elevation_column + Duration_column);
    STK_distance = Result(k,Proposed_distance_column + Duration_column);
    %---------------elevation accuracy-------------------
    if ~isnan(Proposed_elevation) && ~isnan(STK_elevation)
        elevation_accuracy = 1- abs(Proposed_elevation - STK_elevation)/STK_elevation;

        Elevation_count = Elevation_count + 1;
        Sum_Elevation_accuracy = Sum_Elevation_accuracy + elevation_accuracy;

        Result(k,8) = elevation_accuracy;
    end
    %---------------distance accuracy-------------------
    if ~isnan(Proposed_distance) && ~isnan(STK_distance)
        distance_accuracy = 1- abs(Proposed_distance - STK_distance)/STK_distance;
        
        Distance_count = Distance_count + 1;
        Sum_Distance_accuracy = Sum_Distance_accuracy + distance_accuracy;
        
        Result(k,9) = distance_accuracy;
    end
end

Avg_Elevation_accuracy =  Sum_Elevation_accuracy / Elevation_count;
Avg_Distance_accuracy = Sum_Distance_accuracy / Distance_count;
%output
output_Avg_Access_accuracy = Avg_Access_accuracy * 100;
output_Avg_Elevation_accuracy = Avg_Elevation_accuracy * 100;
output_Avg_Distance_accuracy = Avg_Distance_accuracy * 100;
output_ISL_PropoedModel_AND_STK_accuracy = Result;
end

