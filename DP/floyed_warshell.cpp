# include <bits/stdc++.h>

#define INF 9999
#define V 4

using namespace std;

void print_new_graph(int cost[][V])
{
	for (int i = 0; i < V; ++i)
	{
		for (int j = 0; j < V; ++j)
		{
			cout << cost[i][j] <<" ";
		}
		cout <<endl;
	}
}



void floydWarshall(int graph[][V])
{
	int cost[V][V];

	for(int i=0; i<V;i++)
		for(int j=0;j<V;j++)
			cost[i][j] = graph[i][j];



	// choose every vertex as intermediate

	for(int k=0;k<V;k++)
		for(int i=0;i<V;i++)
			for(int j=0; j<V;j++)
				if(cost[i][k]+cost[k][j] < cost[i][j])
					cost[i][j] = cost[i][k]+cost[k][j];


	print_new_graph(cost);



}




int main(int argc, char const *argv[])
{
	//int V=4;
	int graph[V][V] = { {0,   5,  INF, 10},
                        {INF, 0,   3, INF},
                        {INF, INF, 0,   1},
                        {INF, INF, INF, 0}
                      };
 
    // Print the solution
    floydWarshall(graph);
	
	return 0;
}