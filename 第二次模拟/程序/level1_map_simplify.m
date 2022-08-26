%% 第一关
clc;clear;
s = [1 1  2 3 3  4 4  4  5 5  6 6  6  7 7  8 8  9  9  9  9  9  9  10 10 10 11 11 12 12 13 13 14 14 15 16 16 17 17 18 18 19 20 21 21 21 22 23 23 24 24 25 26];
t = [2 25 3 4 25 5 24 25 6 24 7 23 24 8 22 9 22 10 15 16 17 21 22 11 13 15 12 13 13 14 14 15 15 16 16 17 18 18 21 19 20 20 21 22 23 27 23 24 26 25 26 26 27];
G = graph(s,t);
D = distances(G);
disp(['从起点到矿山:',num2str(D(1,12))]);
disp(['从矿山到终点:',num2str(D(12,27))]);

%% 最短路径
% 起点到商店
[start_shop_P1,start_shop_D1] = shortestpath(G,1,15)
% 商店到矿山
[mine_shop_P2,mine_shop_D2] = shortestpath(G,12,15)
% 商店到终点
[end_shop_P3,end_shop_D3] = shortestpath(G,15,27)


