%% 第五关
clc;clear;
s = [1 1 1 2 2 3 3 3 4 4 4 5 6 6  6  7  7  8 9  9  10 10 11 11 12];
t = [2 4 5 3 4 4 8 9 5 6 7 6 7 12 13 11 12 9 10 11 11 13 12 13 13];
G = graph(s,t);
D = distances(G);
plot(G);

%% 最短路径
% 起点到矿山
[start_mine_P1,start_mine_D1] = shortestpath(G,1,9)
% 矿山到终点
[mine_end_P2,mine_end_D2] = shortestpath(G,9,13)
% 商店到终点
[start_end_P3,start_end_D3] = shortestpath(G,1,13)

