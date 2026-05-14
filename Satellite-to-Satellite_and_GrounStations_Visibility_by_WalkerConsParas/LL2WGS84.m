%% 经纬度转WGS84直角坐标系(ECEF)
% 东经正数，西经为负数
% 北纬为正数，南纬为负数
% 输入参数1：纬度；输入参数2：经度；输入参数3：高度
% 经纬度单位：度；高度单位：米
function [x_in_km,y_in_km,z_in_km]=LL2WGS84(latitude,longitude,height)
a = 6378137.0;%单位m
b = 6356752.31424518;%单位m
E = (a * a - b * b) / (a * a);
COSLAT = cos(latitude * pi / 180);
SINLAT = sin(latitude * pi / 180);
COSLONG = cos(longitude * pi / 180);
SINLONG = sin(longitude * pi / 180);
N = a / (sqrt(1 - E * SINLAT * SINLAT));
NH = N + height;
x = NH * COSLAT * COSLONG;
y = NH * COSLAT * SINLONG;
z = (b * b * N / (a * a) + height) * SINLAT;
%output
x_in_km = x / 1000;
y_in_km = y / 1000;
z_in_km = z / 1000;
end