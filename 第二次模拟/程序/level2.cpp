#include <iostream>
#include <map>
using namespace std;
map<pair<int,int>,bool>mp;
const int point[6]={0,2,1,2,1,3};//起点,村庄,矿山,终点
// 特殊点的距离
const int my_distance[6][6]={{0,7,8,9,9,11},{7,0,1,3,4,4},{8,1,0,2,3,3},{9,3,2,0,1,2},{9,4,3,1,0,2},{11,4,3,2,2,0}};
// 特殊点是否相邻
const int f[4][4]={{0,1,1,1},{0,0,1,1},{0,1,0,1},{0,0,0,0}};
// 天气
const int weather[30]={2,2,1,3,1,
        2,3,1,2,2,
		3,2,1,2,2,
		2,3,3,2,2,
		1,1,2,1,3,
		2,1,1,2,2};
// 题目常数
const int  mx=3,my=2;
const int cx=5,cy=10;
// 对应天气的基础消耗,
const int base_x[4]={0,5,8,10};
const int base_y[4]={0,7,6,10};
// 题目中特殊点的数量,
const int n=6;
// 最大质量
const int maxm=1200;
// 初始资金
const int coins=10000;
// 矿山挖矿的基础收益
const int base_gain=1000;
// 截止日期
const int ddl=30;
// 从第d天出发, 从i点到j点的消耗的水,食物,实际天数
int costx[32][6][6];
int costy[32][6][6];
int actual_days[32][6][6];
int opt_coins=0;
int rec[32];//每一天所到达的点的标记,-1代表此时处于最短路径上的某个普通点或已经达到终点
			//其余的数字分别代表当天玩家位于对应的特殊点,对应的情况如qua数组所示
int act[32]; // 每一天的特殊行动情况,2代表挖矿,1代表矿山停止行动,0代表在村庄购买
int ansx[32];//最优路径
int ansact[32];//最优解路径上的行为
int ansg,ansh;//最优解对应的初始水和食物资源量
int g,h;//用于枚举初始水与食物资源量

void dfs(int day,int now,int nm,int c,int x,int y,int type)
{
	act[day]=type;
	rec[day]=now;
	
    // 终点!
	if(point[now]==3)
	{
		// 要乘以1/2吗
	    if(opt_coins<=c+x*cx+y*cy)
	    {
		ansg=g;
		ansh=h;
		
		opt_coins=c+x*cx+y*cy;
		for(int i=0;i<=ddl;i++)
		    ansx[i]=rec[i];
		for(int i=0;i<=ddl;i++)
		    ansact[i]=act[i];
	    }
	    act[day]=-1;
	    rec[day]=-1;
	    return;
	}
	if(day>=ddl)
	{
	    act[day]=-1;
	    rec[day]=-1;
	    return;
	}
	if(point[now]==1)
	    nm=maxm-mx*x-my*y;
	for(int i=0;i<n;i++)
	    if(f[point[now]][point[i]])
	    {
		int tx=costx[day][now][i];
		int ty=costy[day][now][i];
		int ucost=c;
		int ux,uy;
		int um=nm;
		if(x>=tx)
		    ux=x-tx;
		else
		{
		    ux=0;
		    ucost-=2*(tx-x)*cx;
		    um-=(tx-x)*mx;
		}

		if(y>=ty)
		    uy=y-ty;
		else
		{
		    uy=0;
		    ucost-=2*(ty-y)*cy;
		    um-=(ty-y)*my;
		}
		if(ucost<0||um<0)
		    continue;
		dfs(day+actual_days[day][now][i],i,um,ucost,ux,uy,0);
	    }
        // 矿山
	if(point[now]==2)
	{
	    int attday=day;
	    int tx=base_x[weather[attday]];
	    int ty=base_y[weather[attday]];
	    attday++;
	    if(x>=tx)
	    {
		x-=tx;
		tx=0;
	    }
	    else
	    {
		tx-=x;
		x=0;
	    }
	    if(y>=ty)
	    {
		y-=ty;
		ty=0;
	    }
	    else
	    {
		ty-=y;
		y=0;
	    }
        // TODO ?
	    nm-=tx*mx+ty*my;
	    c-=2*tx*cx+2*ty*cy;
	    if(nm>=0&&c>=0)
            // 在村庄不挖矿
		    dfs(attday,now,nm,c,x,y,1);

	    attday=day;
	    tx=base_x[weather[attday]]*2;
	    ty=base_y[weather[attday]]*2;
	    attday++;
	    if(x>=tx)
	    {
		x-=tx;
		tx=0;
	    }
	    else
	    {
		tx-=x;
		x=0;
	    }
	    if(y>=ty)
	    {
		y-=ty;
		ty=0;
	    }
	    else
	    {
		ty-=y;
		y=0;
	    }
	    nm-=tx*mx+ty*my;
	    c-=2*tx*cx+2*ty*cy;
	    c+=base_gain;
	    if(nm>=0&&c>=0)
        // 在矿山挖矿
		dfs(attday,now,nm,c,x,y,2);
	}
    // 普通节点
	rec[day]=-1;
	act[day]=-1;
}

int main()
{
	for(int d=0;d<=ddl;d++)
	{
	    rec[d]=-1;
	    act[d]=-1;
	}
	// 初始化从第d天开始, 从i到j需要消耗的水和食物
	for(int d=0;d<ddl;d++)
	    for(int i=0;i<n;i++)
	        for(int j=0;j<n;j++)
		if(f[point[i]][point[j]])
		{
		    int now=0,count=0,sumx=0,sumy=0;
		    while(count<my_distance[i][j])
		    {
			if(weather[now+d]!=3)
			{
			    count++;
			    sumx+=2*base_x[weather[now+d]];
			    sumy+=2*base_y[weather[now+d]];
			}
			else
			{
			    sumx+=base_x[weather[now+d]];
			    sumy+=base_y[weather[now+d]];
			}
			now++;
			// 超过时间
			if(now+d>=ddl)
			    break;
		    }
			// 超过时间,将sumx和sumy设置为无穷大
			if(count<my_distance[i][j])
			{
			    sumx=sumy=20000;
			    now=30;
			}
			costx[d][i][j]=sumx;
			costy[d][i][j]=sumy;
			actual_days[d][i][j]=now;
		}
	for(int i=0;i<=maxm;i++)
	{
		// 枚举水和食物的质量
	    g=i/mx;
	    h=(maxm-i)/my;
	    if(!mp[make_pair(g,h)])
		dfs(0,0,0,coins-g*cx-h*cy,g,h,-1);
	    mp[make_pair(g,h)]=1;
	}
	for(int i=0;i<=ddl;i++)
	    cout<<i<<":"<<ansx[i]<<";"<<ansact[i]<<endl;
	cout<<endl;
	cout<<opt_coins<<" "<<ansg<<" "<<ansh<<endl;
}