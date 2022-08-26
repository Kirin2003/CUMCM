%% 第一关图
clc;clear;
weather = [2 2 1 3 1 2 3 1 2 2 3 2 1 2 2 2 3 3 2 2 1 1 2 1 3 2 1 1 2 2];

s = [1,2,2,3];
t = [2,3,4,3];
names={'起点','村庄','矿山','终点'};
weights = [6,2,3,1];
G = graph(s,t,weights,names);
plot(G,'EdgeLabel',G.Edges.Weight);