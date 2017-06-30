# include <bits/stdc++.h>
# define INF INT_MAX
using namespace std;
class adjNode
{

	int weight;
	int v;
public:
	adjNode(int _v, int _w) {v =_v; weight= _w;}
	int  getV(){return v;}
	int getweight(){return weight;}
};



class Graph
{
	int V;
	//int weight;
	list <adjNode> *adj;
	void toposortUtil(int v, bool viited[], stack<int>&Stack);
public:
	Graph(int V);
	void addedge(int u, int v,int weight);
	void spath(int v);
};


Graph::Graph(int v)
{

	this->V= v;
	adj = new list<adjNode>[V];
}

void Graph::addedge(int u, int v, int weight)
{
	adjNode node(v,weight);
	adj[u].push_back(node);

}

void Graph::toposortUtil(int v, bool visited[], stack<int> &Stack)
{
	visited[v]= true;

	list<adjNode>::iterator i;
	for(i=adj[v].begin() ; i!=adj[v].end(); ++i)
	{
		adjNode node =*i;
		if(!visited[node.getV()])
			toposortUtil(node.getV(), visited, Stack);

	}
	Stack.push(v);

}

void Graph::spath(int v)
{
	stack<int> Stack;
	int dist[V];

	bool *visited =  new bool[V];

	for(int i=0; i<V;i++)
		visited[i]=false;

	for(int i=0; i<V;i++)
		dist[i]=INF;
	dist[v]=0;
		

	for(int i=0; i<V;i++)
		if(visited[i]==false)
			toposortUtil(i, visited, Stack);


	while(Stack.empty()==false)
	{
		int u= Stack.top();

		Stack.pop();

		list<adjNode>::iterator i;
		if(dist[u]!=INF)
		{
			for(i=adj[u].begin();  i!=adj[u].end(); ++i)
				if(dist[i->getV()] > dist[u] + i->getweight())
					dist[i->getV()] = dist[u] + i->getweight();

		}
	}
	for(int i=0;i<V;i++)
		dist[i] ==INF? cout << "INF" : cout << dist[i] << " ";

}


int main()
{

	Graph g(6);
	g.addedge(0,1,5);
	g.addedge(0,2,3);
	g.addedge(1,3,6);
	g.addedge(1,2,2);
	g.addedge(2,4,4);
	g.addedge(2,5,2);
	g.addedge(2,3,7);
	g.addedge(3,4,-1);
	g.addedge(4,5,-2);

	int s=1;

	cout << " Following is the shortest diatance from source  "<< s << "\n";
	g.spath(s) ;


	return 0;
}