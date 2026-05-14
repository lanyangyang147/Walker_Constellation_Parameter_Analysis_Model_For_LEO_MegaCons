function [output_UTC] = update_UTC_Time_in_tenth_min(Time_in_tenth_min,Init_UTC)
%UPDATE_UTC_TIME 此处显示有关此函数的摘要
%   此处显示详细说明
%Init_UTC = [2022 8 26 0 0 0];%year + month + day + hour + minutes + seconds
year  = Init_UTC(1,1);
month = Init_UTC(1,2);
day   = Init_UTC(1,3);
hour  = Init_UTC(1,4); 
min   = Init_UTC(1,5); 
sec   = Init_UTC(1,6);
%------------ minutes ----------
Time_in_secs = Time_in_tenth_min * 60;
New_hour  = floor(Time_in_secs / 3600);
remining_second = Time_in_secs - New_hour * 3600;
New_min  = floor(remining_second / 60);
New_sec  = remining_second - New_min * 60;

UTC = [year month day hour+New_hour min+New_min sec+New_sec];
%output
output_UTC = UTC;
end

