# include <bits/stdc++.h>

using namespace std;

class Graph
{

	int V;
	list <int> *adj;
	void DFSUtil(int v, bool visited[]);
public:
	Graph(int V);
	void addedge(int u, int v);
	void DFS(int v);

	/* code */
	
};


Graph::Graph(int v)
{
	this->V=v;
	adj = new list<int>[V];
}


void Graph::addedge(int u, int v)
{

	adj[u].push_back(v);
}


void Graph::DFSUtil(int v, bool visited[])
{

	visited[v] = true;
	cout << v << " --> ";

	list<int>:: iterator it;
	for(it=adj[v].begin(); it!=adj[v].end();++it)
		if(!visited[*it])
			DFSUtil(*it, visited);
}


void Graph::DFS(int v)
{
	bool *visited = new bool[V];

	for(int i=0;i<V; i++)
		visited[i] = false;

	DFSUtil(v, visited);
 

}

//-----------------------------------------------------------------------------------


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

	cout << " BFS traversal for node 2 is " << endl;

	g.DFS(2);

	cout << "end";
	cout <<endl;


	return 0;
}