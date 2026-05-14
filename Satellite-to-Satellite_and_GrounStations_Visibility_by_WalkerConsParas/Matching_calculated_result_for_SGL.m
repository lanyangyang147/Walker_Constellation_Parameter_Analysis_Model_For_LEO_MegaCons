function [output_Row_STK_AND_Proposed_Res] = Matching_calculated_result_for_SGL(Proposed_Calc_Result,STK_Result)
%MATCHING_CALCULATED_RESULT 此处显示有关此函数的摘要
%   此处显示详细说明


%Proposed_Calc_Result = [Proposed_Calc_Result(:,1:2) Proposed_Calc_Result(:,4) Proposed_Calc_Result(:,3)];
%Column-format: time + Access+ elevation_in_deg + range_in_km 
%STK_Result        
%Column-format: time+ access + elevation_in_deg + range_in_km
Sum_of_row = Proposed_Calc_Result(end,1);
Sum_of_column = size(Proposed_Calc_Result,2)+size(STK_Result,2)-1;
Proposed_AND_STK_Res = nan * zeros(Sum_of_row,Sum_of_column);
columns_of_proposedModel = size(Proposed_Calc_Result,2);
%-----filling time------
for k = 1:size(Proposed_AND_STK_Res,1)
    Proposed_AND_STK_Res(k,1) = k;
end
%-----filling the proposed data------
for k = 1:size(Proposed_Calc_Result,1)-1
   flag = Proposed_Calc_Result(k,2);
   if k == 1 
      Seg_Start_Time = Proposed_Calc_Result(k,1) + 1;
      Seg_End_Time = Proposed_Calc_Result(k +1 ,1)-1;
   elseif k == size(Proposed_Calc_Result,1)-1
      Seg_Start_Time = Proposed_Calc_Result(k,1);
      Seg_End_Time = Proposed_Calc_Result(k +1 ,1);
   else
      Seg_Start_Time = Proposed_Calc_Result(k,1);
      Seg_End_Time = Proposed_Calc_Result(k +1 ,1)-1;     
   end
   if isnan(flag)
      % do nothing
   else
      for m = Seg_Start_Time:Seg_End_Time
          %Proposed_AND_STK_Res(m,1) = m;
          Proposed_AND_STK_Res(m,2:columns_of_proposedModel) = Proposed_Calc_Result(k,2:end);
      end
   end
end
%-----filling the STK data------

for k = 1:size(STK_Result,1)
    time = STK_Result(k,1);
    if rem(time,1)
        %---not int value
        time_int_value = floor(time);
        diff_value = time - time_int_value;
        if diff_value < 0.5
            row = time_int_value;
            Proposed_AND_STK_Res(row,columns_of_proposedModel + 1:end) = STK_Result(k,2:end);
        end        
    else
        %---int value---
        Proposed_AND_STK_Res(time,columns_of_proposedModel + 1:end) = STK_Result(k,2:end);
    end
end
%output
output_Row_STK_AND_Proposed_Res = Proposed_AND_STK_Res;
end

