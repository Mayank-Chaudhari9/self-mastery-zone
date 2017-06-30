# include <bits/stdc++.h>



using namespace std;


class Graph
{

	int V;
	list<int> *adj;

public:
	Graph(int V);
	void addedge(int v, int w );
	void BFS(int s);

};

Graph::Graph(int v)
{
	this->V=v;

	adj = new list<int>[V];
}

void Graph::addedge(int v, int w)
{
	adj[v].push_back(w);
}
//-----------------------------------------------------------------------------------//

void Graph::BFS(int v)
{
	bool *visited = new bool[V];

	for(int i=0;i<V;i++)
		visited[i]=false;

	list<int> queue;

	visited[v] = true;
	queue.push_back(v);

	list<int>::iterator i;

	while(!queue.empty())
	{
		v=queue.front();
		cout << v << " "<<"->"<<" ";

		queue.pop_front();

		for(i=adj[v].begin();i!=adj[v].end();++i)
			{
				if(!visited[*i])
				{
					visited[*i]=true;
					queue.push_back(*i);
				}
			}
	}





}



int main(int argc, char const *argv[])
{

	Graph g(4);
	g.addedge(0,1);
	g.addedge(0,2);
	g.addedge(1,2);
	g.addedge(2,0);
	g.addedge(2,3);
	g.addedge(3,3);
	//g.addedge(0,1);

	cout << " BFS of Graph is form vertex 2" << endl;

	g.BFS(2);
	 cout << endl;

	return 0;
}