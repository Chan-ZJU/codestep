# 1.0 
## 1.1 

[Leetcode-646](https://leetcode-cn.com/problems/maximum-length-of-pair-chain/)

这道题的标签是动态规划，动态规划的[写法](alg_lab_16.md#)，可以直接用贪心来写，下面是贪心写法。

```cpp
class Solution {
public:
    static bool cmp(vector<int> &a, vector<int> &b) {return a[1]<b[1];}
    int findLongestChain(vector<vector<int>>& pairs) {
        sort(pairs.begin(),pairs.end(), cmp);
        int len = pairs.size();
        int t =  pairs[0][1];
        int k = 1;
        for(int i = 1; i < len ;i ++) {
            if (pairs[i][0] > t) {
                k++;
                t = pairs[i][1];
            }
        }
        return k;
    }
};
```

> 2020/1/17 更新
# 贪心
贪心主要有两点：贪心选择，最优子结构。
贪心选择：贪心策略，局部最优，全局最优，无后效应。
首先要选择合适的贪心策略，每一步都是当前的最优解，步步逼近并且上一步对下一步没有影响从而达到全局最优。

# 题型
贪心的题型主要分为以下几种。

## 装载问题
此处的装载问题为物品可分，若不可分则是0/1背包，而贪心针对0/1背包问题只能达到局部最优得到近似解，无法得到最优解。

### 贪心策略
- 按照重量升序

### 思路
重量升序之后逐个判断装入。

## 活动安排问题
一般是一段时间内有很多不同的时间段的会议，一段会议是不可以中断的。求在这一整段时间内可以安排最多数量的会议。

### 贪心策略
- 按照会议开始时间排序。
- 按照会议总时间排序，时间短的优先。
- 按照会议结束的时间排序。

若按照会议开始时间作为贪心策略，假如这个会议持续时间很长，也就是结束时间比较短，而为了安排较多的会议的话显然不合适。
若按照会议总时间短的排序，假如这个虽然总时长很短，但是开始时间较迟，如果先安排这个会议，前面的时间显然都浪费了，这样也不合适。
若按照会议的结束时间作为贪心策略，会议结束快的显然开始也快，而时长也是较短的，显然结合了上述两者的优势。

### 思路

按照会议结束时间来排序，如果结束时间相同，开始时间晚的优先。排序后再来判断每一个活动参与的情况。

## 最短路问题
最短路是图论的一部分，单也应用了贪心的思想，每一步的长度都是最短，全局自然最短。

## 最小生成树
按照权值最小，将全部的点都覆盖也蕴含有贪心思想。

## 哈夫曼编码
带权路径最小的哈夫曼树也应用了贪心思想。


## 杂题

# 装载问题题目

### HDU_2111_Saving HDU

```c++
/**
 * 题目：HDU_2111_Saving HDU
 * 来源：http://acm.hdu.edu.cn/showproblem.php?pid=2111
 * 思路：这个题有点坑，注意是题目中给得是单价，而非总价值。
 * 结果：32188886	2020-01-18 01:19:13	Accepted	2111	0MS	1396K	796 B	G++	weijiew
*/
#include <iostream>
#include <algorithm>
using namespace std;
const int MAXSIZE = 110;

struct Value{
    int x , y ;
}a[MAXSIZE];

int cmp(Value a, Value b){
    return a.x > b.x;
}
int main(){
    int v, n;
    while(cin >> v){
        if ( v == 0){
        	break;
		}
        cin >> n ;
        for (int i = 0; i < n; i++){
            cin >> a[i].x >> a[i].y;
        }
        // 升序排列
        sort(a,a+n,cmp);
        int ans = 0;
        for (int i = 0; i < n; i++){
            // 判断当前容量是否够用，够用就放入计算所得价值，不够就计算剩余容量得价值
            if (v >= a[i].y)
            {
                ans += a[i].x * a[i].y;
                v -= a[i].y;
            }else
            {
                ans += a[i].x * v;
                // 两者都行，如果直接break，v可以不用为零
                // v = 0;
                break;
            }
            
        }
        cout << ans << endl;
    }
    return 0;
}
```

# 简单背包问题

### HDU_1009_FatMouse' Trade

```c++
/**
 * 题目：HDU_1009_FatMouse' Trade
 * 来源：http://acm.hdu.edu.cn/showproblem.php?pid=1009
 * 思路：贪心策略为性价比最高的优先，然后依次贪心。
 * 结果：32196913	2020-01-18 18:39:12	Accepted	1009	561MS	1520K	794 B	G++	weijiew
*/
#include <iostream>
#include <algorithm>
# define MAXSIZE 1010

using namespace std;
struct room{
    double j , f , h;
}a[MAXSIZE];

int cmp(room a , room b){
    return a.h > b.h;
}

int main() {
    int m, n;
    while (cin >> m >> n) {
        if (m == -1 || n == -1){
            break;
        }
        for (int i = 0; i < n; i++){
            cin >> a[i].j >> a[i].f;
            a[i].h = a[i].j / a[i].f;
        }
        sort(a , a + n,cmp);
        double sum = 0 ;
        for (int i = 0; i < n; i++){
            if(a[i].f <= m){
                sum += a[i].j;
                m -= a[i].f;
            }else{
                sum += a[i].h * m;
                break;
            }
        }
        printf("%.3lf\n",sum);
    }
    return 0;
}
```

### [HDU_1052_Tian Ji -- The Horse Racing](http://acm.hdu.edu.cn/showproblem.php?pid=1052)

这道题有点复杂，分情况讨论，有点难。
```c++
/**
 * 题目：HDU_1052_Tian Ji -- The Horse Racing
 * 来源：http://acm.hdu.edu.cn/showproblem.php?pid=1052
 * 思路：注释
 * 结果：32201226	2020-01-19 00:23:44	Accepted	1052	93MS	1420K	1607 B	G++	weijiew
**/
# include <iostream>
# include <algorithm>
# define MAXSIZE 1010
using namespace std;
int a[MAXSIZE] , b[MAXSIZE];
int cmp(int a, int b){
    return a > b ;
}
int main(){
    int n;
    while ( cin >> n && n){
        for ( int i = 0; i < n; i++){
            cin >> a[i];
        }
        for (int i = 0; i < n; i++){
            cin >> b[i];
        }
        sort(a , a + n, cmp);
        sort(b , b + n, cmp);
        // 设置头尾两个标记
        int ai = 0 , aj = n - 1;
        int bi = 0 , bj = n - 1;
        int sum = 0 ;
        while(ai <= aj && bi <= bj){
            // 田忌的最快的🐎比齐王最快的🐎还要快。
            if (a[ai] > b[bi]){
                sum += 200;
                ai ++;
                bi ++;
            }
            // 田忌的最快的马速度低于齐王最快的马，采用田忌最慢的马拖齐王最快的马下水
            else if (a[ai] < b[bi]){
                sum -= 200;
                aj --;
                bi ++;
            } 
            /** 田忌的和齐王两只速度最快的马速度相等时比较两者最慢的马
             *平一场不如一胜一负，一胜一负，负的那一场会将齐王最快的马拖下水，
             * 可能会使田忌最快的马再赢一场。田忌的马平均水平低于齐王，一胜一负便于尽早结束比赛。
             */
            else {
               if (a[aj] > b[bj]){
                  sum += 200;
                  aj --;
                  bj --;
              }
              else if(a[aj] < b[bj]){
                  sum -= 200;
                  bi ++;
                  aj --;
              }
              else {
                /**
                 * 速度最慢的马低于速度最快的马时要扣钱
                 * 而速度最慢的马高于速度最快的马的情况已经提过了。
                */
                  if (a[aj] < b[bi]){
                      sum -= 200;
                  }
                      aj --;
                      bi ++;
              }
           }
        }
        cout << sum << endl;
    }
    return 0;
}
```

# 会议安排问题

## [HDU_2037_今年暑假不AC](http://acm.hdu.edu.cn/showproblem.php?pid=2037)

```c++
/**
 * 题目：HDU_2037_今年暑假不AC
 * 思路：按照结束的时间排序，越早结束看的节目越多
 * 来源：http://acm.hdu.edu.cn/showproblem.php?pid=2037
 * 结果：32219623	2020-01-20 18:53:49	Accepted	2037	0MS	1400K	656B	G++	weijiew
*/
#include <iostream>
#include <algorithm>
using namespace std;
struct tv{
    int s , e;
}a[110];
int cmp(tv a, tv b){
    return a.e == b.e ? a.s > b.s : a.e < b.e;
}
int main(){
    int n;
    while (cin >> n && n)
    {
        for (int i = 0; i < n; i++){
            cin >> a[i].s >> a[i].e;
        }
        
        sort(a , a + n, cmp);
        int ans = 1 , t;
        
        t = a[0].e;
        for (int i = 1; i < n; i++){
            if (a[i].s >= t)
            {
                ans ++;
                t = a[i].e;
            }
            
        }
        cout << ans << endl;
    }
    
    return 0;
}
``` 

# 贪心杂题
## [HDU_1049_Climbing Worm](http://acm.hdu.edu.cn/showproblem.php?pid=1049)

```c++
/**
 * 题目：HDU_1049_Climbing Worm
 * 来源：http://acm.hdu.edu.cn/showproblem.php?pid=1049
 * 思路：直接模拟一下就ok，分成两阶段：爬上去，掉下来。最后可以直接爬上去，而掉下来的时间就不用计算了。
 * 结果：32205931	2020-01-19 15:41:16	Accepted	1049	15MS	1396K	428 B	G++	weijiew
*/
#include <iostream>
using namespace std;
int main() {
    int n , u , d;
    while (cin >> n >> u >> d && n) {
        int ans = 0 , sum = 0;
        while (1) {
            sum += u;
            ans ++;
            if (sum >= n)
            {
                break;
            }else{
                sum -= d ;
            }
            ans ++ ;
        }
        cout << ans << endl;
    }
    return 0;
}
```

## [HDU_1234_开门人和关门人](http://acm.hdu.edu.cn/showproblem.php?pid=1234)

```cpp
/**
 * 题目：HDU_1234_开门人和关门人
 * 来源：http://acm.hdu.edu.cn/showproblem.php?pid=1234
 * 思路：注意输入格式，转换成秒，排序输出即可。
 * 结果：32220917	2020-01-20 20:25:41	Accepted	1234	0MS	1432K	935 B	G++	weijiew
*/
#include <iostream>
#include <algorithm>
#define MAXSIZE 10000
using namespace std;
struct tim{
    char name[16];
    int start;
    int end;
}a[MAXSIZE];
int cmp1(tim a1, tim a2){
    return a1.start < a2.start;
}
int cmp2(tim a1, tim a2){
    return a1.end > a2.end;
}
int main(){
    int n , m;
    int h1, m1, s1;
    int h2, m2, s2;
    cin >> n;
    while (n --) 
    {
        cin >> m;
        for (int i = 0; i < m; i++){
            // 注意scanf的输入方式
			scanf("%s %d:%d:%d %d:%d:%d", a[i].name, &h1, &m1, &s1, &h2, &m2, &s2);
            a[i].start = h1 * 3600 + m1 * 60 + s1 ;
            a[i].end = h2 * 3600 + m2 * 60 + s2;
        }
        sort(a , a + m, cmp1);
        printf("%s ", a[0].name);
        sort(a , a + m, cmp2);
        printf("%s\n", a[0].name);
    }
    
    return 0;
}
```

> 2019/08/05记录
## 1234: 出租车费

时间限制: 1 Sec  内存限制: 32 MB
提交: 175  解决: 83
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

某市出租车计价规则如下：起步4公里10元，即使你的行程没超过4公里；接下来的4公里，每公里2元；之后每公里2.4元。行程的最后一段即使不到1公里，也当作1公里计费。
一个乘客可以根据行程公里数合理安排坐车方式来使自己的打车费最小。
例如，整个行程为16公里，乘客应该将行程分成长度相同的两部分，每部分花费18元，总共花费36元。如果坐出租车一次走完全程要花费37.2元。
现在给你整个行程的公里数，请你计算坐出租车的最小花费。

**输入**

输入包含多组测试数据。每组输入一个正整数n（n<10000000），表示整个行程的公里数。
当n=0时，输入结束。

**输出**

对于每组输入，输出最小花费。如果需要的话，保留一位小数。

**样例输入**

 3
9
16
0

**样例输出**

10
20.4
36

```c++
#include<iostream>
#include<algorithm>
using namespace std;
const double eps = 1e-6;
int main(){
	int n;
	double sum=0;
	while(cin>>n&&n!=0){
		sum=0;
		if(n<=4){
			sum=10;
		}else if(n<=8&&n>4){
				sum = 10+2*(n-4);
		}else if(n>=8){
			while(n>=8){
				sum+=18;
				n-=8;
			}
			if(n<=4){
				sum += 2.4*n;
			}else{
				sum += 10+(n-4)*2;
			}
		}
		int tmp = (int)sum;
		if(sum-tmp<eps)
		printf("%d\n",tmp);
		else printf("%.1lf\n",sum);
	}
	return 0;
}
```
**总结：**
路程固定，钱最少。
1.前4公里10元。
2. 4-8每公里2元，
3. 之后的每公里2.4元。
前8公里花费18元，花费固定，超过八公里出现选择。
如果从头开始要花10元，按2.4收费花9.6元，显然按2.4。
如果超过12公里，第13公里按2.4计费12元，按照一二部分和计费也是12元，
前者的斜率是2.4，后者的斜率是2，显然后者增长缓慢省钱。采用后者。


## 1248: 排队打水问题（water）

时间限制: 1 Sec  内存限制: 128 MB
提交: 162  解决: 50
您该题的状态：已完成
[提交][状态][讨论版]

 **题目描述**

有n个人排队到m个水龙头去打水，他们装满水桶的时间t1, t2 , ……, tn为整数且各不相同，应如何安排他们的打水顺序才能使他们花费的总时间最少?  只有一组输入数据哦。

**输入**

4 2 （ n m ）

2 6 4 5 （t1 t2 …… tn）

**输出**

23（所有人的花费时间总和）

**样例输入**

 4 2
2 6 4 5

**样例输出**

23

```c++
#include<iostream>
#include<algorithm>
using namespace std;
int main(){
	int a[10000],d[10000],n,m,sum,i;
	cin>>n>>m;
	for(i=0;i<n;i++){
		cin>>a[i];
	}
	sort(a,a+n);
	for(i=0;i<n;i++){
		sort(d,d+m); 
		sum+=d[0]+a[i];
		d[0]+=a[i];
	}
	cout<<sum<<endl;
	return 0;
}
```
**总结：**
升序交叉算和。
室友做法
```c++
#include<iostream>
#include<algorithm>
#include<cstring>
using namespace std;
int main() {
	int n,m,x[1000];
	memset(x,0,sizeof(x));
	cin>>n>>m;
	for(int i=0; i<n; i++) {
		cin>>x[i];
	}
	sort(x,x+n);
	int sum=0,cnt=0;
	for(int i=0; i<n; i++) {
		if(i<=m-1) {
			sum+=x[i];
		} else  {
			int j=i;
			while(j>=0){
				sum=sum+x[j];
//				cout<<" 1 "<<sum<<endl;
//				cout<<x[j]<<" "<<j<<endl;
				j=j-m;
			}
		}
	}
	cout<<sum<<endl;
	return 0;
}
```


## 1249: 均分纸牌（playcard）

时间限制: 1 Sec  内存限制: 128 MB
提交: 150  解决: 87
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

有 N 堆纸牌，编号分别为 1，2，…, N。每堆上有若干张，但纸牌总数必为 N 的倍数。可以在任一堆上取若于张纸牌，然后移动。 
移牌规则为：在编号为 1 堆上取的纸牌，只能移到编号为 2 的堆上；在编号为 N 的堆上取的纸牌，只能移到编号为 N-1 的堆上；其他堆上取的纸牌，可以移到相邻左边或右边的堆上。 
现在要求找出一种移动方法，用最少的移动次数使每堆上纸牌数都一样多。 

例如 N=4，4 堆纸牌数分别为：　　①　9　②　8　③　17　④　6

移动3次可达到目的：

从 ③ 取 4 张牌放到 ④ （9 8 13 10） -> 从 ③ 取 3 张牌放到 ②（9 11 10 10）-> 从 ② 取 1 张牌放到①（10 10 10 10）。 

**输入**

第一行N。第二行A1 A2 … An （每堆纸牌初始数） 

**输出**

所有堆均达到相等时的最少移动次数。 （1 <= N <= 100，l<= Ai <=10000 ）

**样例输入**

 4
9 8 17 6

**样例输出**

3
```c++
#include<iostream>
using namespace std;
int main(){
	int n,a[100],k=0,sum=0,s;
	cin>>n;
	for(int i=0;i<n;i++){
		cin>>a[i];
		sum+=a[i];
	}
	s=sum/n;
	for(int i=0;i<n;i++){
		if(a[i]!=s){
			a[i+1] -= s-a[i];
			a[i] += s-a[i];
			k++;
		}
	}
	cout<<k<<endl;
	return 0;
}
```
## 1736: 看电视

时间限制: 1 Sec  内存限制: 32 MB
提交: 133  解决: 90
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

暑假到了，小明终于可以开心的看电视了。但是小明喜欢的节目太多了，他希望尽量多的看到完整的节目。
现在他把他喜欢的电视节目的转播时间表给你，你能帮他合理安排吗？

**输入**

输入包含多组测试数据。每组输入的第一行是一个整数n（n<=100），表示小明喜欢的节目的总数。
接下来n行，每行输入两个整数si和ei（1<=i<=n），表示第i个节目的开始和结束时间，为了简化问题，每个时间都用一个正整数表示。
当n=0时，输入结束。

**输出**

对于每组输入，输出能完整看到的电视节目的个数。

**样例输入**

 12
1 3
3 4
0 7
3 8
15 19
15 20
10 15
8 18
6 12
5 10
4 14
2 9
0

**样例输出**

5

```c++
#include<iostream>
#include<algorithm>
#include<fstream>
using namespace std;
const int maxn=110;
struct node {
	int x;
	int y;
}ds[maxn];
bool cmp(node a,node b){
	return a.y<b.y;
}
int main(){
	int n,i,j,lastx,k;
	while(cin>>n&&n!=0){
		k=1;
		for(i=0;i<n;i++){
		cin>>ds[i].x>>ds[i].y;		
		}
		sort(ds,ds+n,cmp);
		lastx=ds[0].y;
		for(i=0;i<n;i++){
			if(ds[i].x>=lastx){
				lastx = ds[i].y;
				k++;
			}
		}
		cout<<k<<endl;
	}
	return 0;
}
```
**总结：**
结构体排序，不能排节目开始的时间，应该排节目结束的时间。
完整节目意味着节目之间没有交集。


# 8.6

## 1253: 磁带最大利用率问题

时间限制: 1 Sec  内存限制: 128 MB
提交: 131  解决: 82
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

设有n个程序{1,2，...,n}要存放在长度为L的磁带上。程序i存放在磁带上的长度是li，1<=i<=n.

程序存储问题要求确定这n个程序在磁带上的一个存储方案，使得能够在磁带上存储尽可能多的程序。在保证存储最多程序的前提下，要求磁带的利用率最大。

编程任务：对于给定的n个程序存放在磁带上的长度，编程计算磁带上最多可以存储的程序数和占用磁带的长度。

**输入**

第一行是2个正整数，分别表示文件个数n和磁带长度L。第二行中，有n个正整数，表示程序存放在磁带上的长度。

**输出**

第一行输出最多可以存储的程序数和占用磁带的长度；第二行输出存放在磁带上的每个程序的长度，（输出程序次序应与输入数据次序保持一致）

**样例输入**

 9 50
2 3 13 8 80 20 21 22 23

**样例输出**

5 49
2 3 13 8 23
```c++
#include<iostream>
#include<algorithm>
using namespace std;
struct node{
	int x;
	int y;
} a[100];
bool cmp0(node a,node b){
	return a.x < b.x;
}
bool cmp1(node a,node b){
	return a.y < b.y;
}
int main(){
	int i,n,l,sum=0,k=0,m,p;
	cin>>n>>l;
	for(i=0;i<n;i++){
		cin>>a[i].x;
		a[i].y = i;
	}
	sort(a,a+n,cmp0);
	for(i=0;i<n;i++){
		sum +=a[i].x;
		if(sum>l){
			break;
		}
		k++;
	}
	sum=0;
	for(i=0;i<k-1;i++){
		sum += a[i].x;
	}
	m = l-sum;
	for(i=n-1;i>=0;i--){
		if(a[i].x<m){
			sum+=a[i].x;
			p=i;
			break;
		}
	}
	cout<<k<<" "<<sum<<endl;
	sort(a,a+k,cmp1);
	for(i=0;i<k-1;i++){
		cout<<a[i].x<<" ";
	}
	cout<<a[p].x<<endl;
	return 0;
} 
```
**总结：**
我真菜。俩小时，md，注意顺序。

## 1255: 寻找最大数X

时间限制: 1 Sec  内存限制: 128 MB
提交: 125  解决: 79
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

请在整数 n 中删除m个数字, 使得余下的数字按原次序组成的新数最大，

比如当n=92081346718538，m=10时，则新的最大数是9888

**输入**

第一行输入一个正整数T，表示有T组测试数据
每组测试数据占一行，每行有两个数n,m（n可能是一个很大的整数，但其位数不超过100位，并且保证数据首位非0，m小于整数n的位数）

**输出**

每组测试数据的输出占一行，输出剩余的数字按原次序组成的最大新数

**样例输入**

 3
92081346718538 10
1008908 5
890 1

 **样例输出**

9888
98
90

```c++
#include<iostream>
#include<cstring>
using namespace std;
int main(){
	int t,len,i,j,temp[101],b,c[101],max;
	char a[101];
	cin>>t;
	getchar();
	while(t--){
		cin>>a>>b;
		len = strlen(a);
		int k=-1;
		for(i=0;i<len-b;i++){
			max = 0;
			for(j=k+1;j<=b+i;j++){
				if(max<a[j]){
					max = a[j];
					k=j;
				}
			}
			cout<<a[k];
		}
		cout<<endl;
	}
	return 0;
}

```
## 2145: 寻找最大数（三）

时间限制: 1 Sec  内存限制: 64 MB
提交: 60  解决: 18
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

给出一个整数N，每次可以移动2个相邻数位上的数字，最多移动K次，得到一个新的整数。

求这个新的整数的最大值是多少。

**输入**

多组测试数据。 每组测试数据占一行，每行有两个数N和K (1 ≤ N≤ 10^18; 0 ≤ K ≤ 100).

**输出**

每组测试数据的输出占一行，输出移动后得到的新的整数的最大值。

**样例输入**

 1990 1
100 0
9090000078001234 6

**样例输出**

9190
100
9907000008001234

```c++
#include<stdio.h>
#include<string.h>
int main(){
    char a[20],temp;
    int k,l,t;
    while(~scanf("%s %d",a,&k))
    {
        l=strlen(a);
        for(int i=0;i<l&&k!=0;i++)
        {
            t=i;
            for(int j=t;j<=k+i&&j<l;j++)
            {
                if(a[j]>a[t]){
                    t=j;
                }
            }
            for(int j=t;j>i;j--)
            {
                temp=a[j];
                a[j]=a[j-1];
                a[j-1]=temp;
            }
            k-=t-i;
        }
        puts(a);
    }
}
```


```c++
#include<iostream>
#include<cstring>
using namespace std;
int swap(int x,int y){
	int t=x;
	x=y;
	y=t;
	return x,y;
}
int main(){
	char a[101];
	int b,k=0,i,j;
	while(cin>>a>>b){
			k=0;
				for(i=1;i<strlen(a)&&b!=0;i++){
					for(j=i;j>0;j--){
						if(a[j]>a[j-1]){
							if(k<b){
							swap(a[j],a[j-1]);
							k++;								
							}else{
								break;
							}
						}
					}
				}
			puts(a);
	}
	return 0;
}

```
## 2113: 找点

时间限制: 2 Sec  内存限制: 64 MB
提交: 166  解决: 78
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

上数学课时，老师给了LYH一些闭区间，让他取尽量少的点，使得每个闭区间内至少有一个点。但是这几天LYH太忙了，你们帮帮他吗？

**输入**

多组测试数据。 每组数据先输入一个N，表示有N个闭区间（N≤100)。 接下来N行，每行输入两个数a，b(0≤a≤b≤100），表示区间的两个端点。

**输出**

输出一个整数，表示最少需要找几个点。

**样例输入**

 4
1 5
2 4
1 4
2 3
3
1 2
3 4
5 6
1
2 2

**样例输出**

1
3
1
```c++
#include<iostream>
#include<cstring>
#include<algorithm>
using namespace std;
struct node{
	int x;
	int y;
}a[101];
bool cmp(node a,node b){
	if(a.y==b.y)return a.x<b.x;
	else return a.y<b.y;
}
int main(){
	int n,i,sum=0;
	while(cin>>n){
		for(i=0;i<n;i++){
			cin>>a[i].x>>a[i].y;
		}
		sum=1;
		sort(a,a+n,cmp);
		int t=a[0].y;
		for(i=1;i<n;i++){
			if(a[i].x>t){
				sum++;
				t=a[i].y;
			}
		}
		cout<<sum<<endl; 
	}
	return 0;
}
```
**总结：**
按右端点排序，右端点相同按左端点排序，小区间放前面，然后依次更新自增。

# 8.7

## 1259: 找零钱

时间限制: 1 Sec  内存限制: 128 MB
提交: 106  解决: 75
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

小智去超市买东西，买了不超过一百块的东西。收银员想尽量用少的纸币来找钱。
纸币面额分为50 20 10 5 1 五种。请在知道要找多少钱n给小明的情况下，输出纸币数量最少的方案。 1<=n<=99;

**输入**

有多组数据  1<=n<=99;

 **输出**

对于每种数量不为0的纸币，输出他们的面值*数量，再加起来输出

**样例输入**

 25
32

**样例输出**

20*1+5*1
20*1+10*1+1*2
```c++
#include<iostream>
using namespace std;
int main(){
	int a[5]={50,20,10,5,1},b[5],n,i,first=0;
	while(cin>>n){
		first=0;
		for(i=0;i<5;i++){
			b[i] =n/a[i];
			n = n%a[i];
		}
		for(i=0;i<5;i++){			
			if(b[i]!=0&&first==0){	
			cout<<a[i]<<"*"<<b[i];
			first = 1;
			} else if(b[i]!=0){
			cout<<"+"<<a[i]<<"*"<<b[i];
			}
		}
		cout<<endl; 
	}
	return 0;
}
```

## 1803: 会场安排问题

时间限制: 3 Sec  内存限制: 64 MB
提交: 199  解决: 84
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

学校的小礼堂每天都会有许多活动，有时间这些活动的计划时间会发生冲突，需要选择出一些活动进行举办。小刘的工作就是安排学校小礼堂的活动，每个时间最多安排一个活动。现在小刘有一些活动计划的时间表，他想尽可能的安排更多的活动，请问他该如何安排。

**输入**

第一行是一个整型数m(m<100)表示共有m组测试数据。
每组测试数据的第一行是一个整数n(1<n<10000)表示该测试数据共有n个活动。
随后的n行，每行有两个正整数Bi,Ei(0<=Bi,Ei<10000),分别表示第i个活动的起始与结束时间（Bi<=Ei)

**输出**

对于每一组输入，输出最多能够安排的活动数量。 每组的输出占一行

**样例输入**

 2
2
1 10
10 11
3
1 10
10 11
11 20

**样例输出**

1
2

```c++
#include<iostream>
#include<algorithm>
using namespace std;
struct node{
	int l;
	int r;
}a[10001];
bool cmp(node a,node b){
	if(a.r==b.r)return a.l<b.l;
	else return a.r<b.r;
}
int main(){
	int m,n,i;
	cin>>m;
	while(m--){
		cin>>n;
		for(i=0;i<n;i++){
			cin>>a[i].l>>a[i].r;
		}
		sort(a,a+n,cmp);
		int t = a[0].r,k=1;
		for(i=0;i<n;i++){
			if(t+1<=a[i].l){
				k++;
				t=a[i].r;
			}
		}
		cout<<k<<endl;
	}
	return 0;
}
```
**总结：**
注意k+1 下一个时间的开始不能等于上一个时间的结束！

## 2143: 非洲小孩

时间限制: 1 Sec  内存限制: 64 MB
提交: 20  解决: 13
您该题的状态：未开始
[提交][状态][讨论版]

**题目描述**

家住非洲的小孩，都很黑。为什么呢？
第一，他们地处热带，太阳辐射严重。
第二，他们不经常洗澡。（常年缺水，怎么洗澡。）
现在，在一个非洲部落里，他们只有一个地方洗澡，并且，洗澡时间很短，瞬间有木有！！（这也是没有的办法，缺水啊！！）
每个小孩有一个时间段能够洗澡。并且，他们是可以一起洗的（不管你是男孩是女孩）。
那么，什么时间洗澡，谁应该来洗，由谁决定的呢？那必然是他们伟大的“澡”神啊。“澡”神有一个时间表，记录着该部落的小孩，什么时候段可以洗澡。现在，“澡”神要问你，一天内，他需要最少开启和关闭多少次洗澡的水龙头呢？因为，开启和关闭一次水龙头是非常的费力气的，即便，这也是瞬间完成的。

**输入**

多组数据
第一行一个0<n<=100。
接下来n行，每行一个时间段。H1H1:M1M1-H2H2:M2M2，24小时制。
保证该时间段是在一天之内的。但是，不保证，H1H1:M1M1先于H2H2:M2M2。

**输出**

题目描述，“澡”神最少需要开启和关闭多少次水龙头呢？

**样例输入**

 1
00:12-12:12
3
00:12-13:14
13:13-18:00
17:00-19:14

**样例输出**

1
2

```c++
#include<iostream>
#include<algorithm>
using namespace std;
struct node{
	int l1;
	int l2;
	int l3;
	int r1;
	int r2;
	int r3;
}a[10001];
bool cmp(node a,node b){
	if(a.r3==b.r3)return a.l3<b.l3;
	else return a.r3<b.r3;
}
int main(){
	int n,i;
	while(cin>>n){
		for(i=0;i<n;i++){
			scanf("%d:%d-%d:%d",
			a[i].l1,a[i].l2,a[i].r1,a[i].r2);
			a[i].l3 = a[i].l1*60+a[i].l2;
			a[i].r3 = a[i].r1*60+a[i].r3;
			if(a[i].l3>a[i].r3){
				int p=a[i].l3;
				a[i].l3 =a[i].r3;
				a[i].r3 = p;
			}
		}
		sort(a,a+n,cmp);
		int t=a[0].r3;
		int k=0;
		for(i=0;i<n;i++){
			if(t<a[i].l3){
				k++;
				t=a[i].r3;
			}
		}
		cout<<k<<endl;
	} 
	return 0;
}
```

```c++
#include<iostream>
#include<algorithm>
using namespace std;
struct Node{
	int x,y;
}time[101];
int cmp(Node a,Node b){
	if(a.y==b.y)return a.x<b.x;
	else return a.y<b.y;
}
int main(){
	int n,i,a,b,c,d;
	while(cin>>n){
		for(i=0;i<n;i++){
			scanf("%d:%d-%d:%d",&a,&b,&c,&d);
			time[i].x = a*60+b;
			time[i].y = c*60+d;
			if(time[i].x>time[i].y){
				swap(time[i].x,time[i].y);
			}
		}
		sort(time,time+n,cmp);
		int k=1;
		for(i=0;i<n-1;i++){
			if(time[i].y>=time[i+1].x){
				time[i+1].y = min(time[i].y,time[i+1].y);
			}else k++;
		}
		cout<<k<<endl; 
	}
	return 0;
}
```


# 8.8
## 1193: 笨鸟先飞

时间限制: 1 Sec  内存限制: 32 MB
提交: 118  解决: 50
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

多多是一只小菜鸟，都说笨鸟先飞，多多也想来个菜鸟先飞。于是它从0点出发，一开始的飞行速度为1m/s，每过一个单位时间多多的飞行速度比上一个单位时间的飞行速度快2m/s，问n（0<n<10^5）个单位时间之后多多飞了多远?

**输入**

先输入一个整数T表示有几组数据。每组数据输入一个n，表示多多飞行的时间。

**输出**

输出多多飞行了多远，因为数字很大，所以对10000取模。

**样例输入**

 2
1
2

**样例输出**

1
4
**思路：** 
根据题目累加即可，水题，注意取模，每算一次取模一次。
```c++
#include<iostream>
using namespace std;
int main(){
	int t,n,sum;
	cin>>t;
	while(t--){
		int sum=0;
		int a=1;
		cin>>n;
		for(int i=0;i<n;i++){
			sum = (sum+a)%10000;
			a = (a+2)%10000;
		}
		cout<<sum<<endl;
	}
	return 0;
}
```


## 1174: 猜数字

时间限制: 1 Sec  内存限制: 32 MB
提交: 221  解决: 105
您该题的状态：已完成
[提交][状态][讨论版]

**题目描述**

现在，我想让你猜一个数字x（1000<=x<=9999），它满足以下要求：
（1）x % a = 0；
（2）(x+1) % b = 0；
（3）(x+2) % c = 0；
其中1<=a，b，c<=100。
给你a，b，c的值，你能告诉我x是多少吗？

**输入**

输入的第一行为c，表示测试样例的个数。接下来的c行每行包括a，b，c三个整数。

**输出**

对于每一个测试样例，输出所求的x，如果x不存在，则输出Impossible。

**样例输入**

 2
44 38 49
25 56 3

**样例输出**

Impossible
2575

```c++
#include<iostream>
using namespace std;
int main(){
	int n,a,b,c;
	cin>>n;
	while(n--){
		cin>>a>>b>>c;
		int k=0;
		for(int i=1000;i<10000;i++){
			if(i%a==0&&(i+1)%b==0&&(i+2)%c==0){
				cout<<i<<endl;
				break;
			}else{
				k++;
			}
		}
		if(k==9000){
			cout<<"Impossible"<<endl;
		} 
	}
	return 0;
} 
```
 **总结：**
枚举即可。


## 今年暑假不AC

Time Limit: 2000/1000 MS (Java/Others)    Memory Limit: 65536/32768 K (Java/Others)
Total Submission(s): 90003    Accepted Submission(s): 48058




## Repair the Wall

Time Limit: 5000/1000 MS (Java/Others)    Memory Limit: 32768/32768 K (Java/Others)
Total Submission(s): 7876    Accepted Submission(s): 3632


**Problem Description**
Long time ago , Kitty lived in a small village. The air was fresh and the scenery was very beautiful. The only thing that troubled her is the typhoon.

When the typhoon came, everything is terrible. It kept blowing and raining for a long time. And what made the situation worse was that all of Kitty's walls were made of wood.

One day, Kitty found that there was a crack in the wall. The shape of the crack is 
a rectangle with the size of 1×L (in inch). Luckly Kitty got N blocks and a saw(锯子) from her neighbors.
The shape of the blocks were rectangle too, and the width of all blocks were 1 inch. So, with the help of saw, Kitty could cut down some of the blocks(of course she could use it directly without cutting) and put them in the crack, and the wall may be repaired perfectly, without any gap.

Now, Kitty knew the size of each blocks, and wanted to use as fewer as possible of the blocks to repair the wall, could you help her ?
 

**Input**
The problem contains many test cases, please process to the end of file( EOF ).
Each test case contains two lines.
In the first line, there are two integers L(0<L<1000000000) and N(0<=N<600) which
mentioned above.
In the second line, there are N positive integers. The ith integer Ai(0<Ai<1000000000 ) means that the ith block has the size of 1×Ai (in inch).
 

**Output**
For each test case , print an integer which represents the minimal number of blocks are needed.
If Kitty could not repair the wall, just print "impossible" instead.
 

**Sample Input**
5 3
3 2 1
5 2
2 1
 

**Sample Output**
2
impossible
```c++
#include<stdio.h>
#include<string.h>
#include<algorithm>
using namespace std;
int a[1020];
int main()
{
    int m,n,j;
    while(~scanf("%d %d",&m,&n))
    {
        int sum=0,f=0,z=0;
        for(int i=0;i<n;i++)
            scanf("%d",&a[i]);
        sort(a,a+n);
        for(int i=n-1;i>=0;i--)
        {
           sum+=a[i];
           z++;
           if(sum>=m)
           {
               f=1;
               break;
           }
        }
        if(f==0)
            printf("impossible\n");
        else
            printf("%d\n",z);
 
    }
}
```

# 参考
1. 《趣学算法》
2. 《算法导论》