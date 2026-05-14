function [output_ProposedModel_StartRow,output_ProposedModel_EndRow] = find_Access_Segment_info(Row,Result,judge_column)
%FIND_ACCESS_SEGMENT_INFO 此处显示有关此函数的摘要
%   此处显示详细说明
for k = Row:size(Result,1)
    if ~isnan(Result(k,judge_column))
       ProposedModel_StartRow = k;
       for m = ProposedModel_StartRow:size(Result,1)
            if isnan(Result(m,judge_column))
               ProposedModel_EndRow = m - 1;
               break;
            elseif m == size(Result,1)
               ProposedModel_EndRow = m;
               break;
            end
       end
       break;
    elseif k == size(Result,1)
       ProposedModel_StartRow = size(Result,1);
       ProposedModel_EndRow = size(Result,1);
    end
end


%output
output_ProposedModel_StartRow = ProposedModel_StartRow;
output_ProposedModel_EndRow = ProposedModel_EndRow;
end

