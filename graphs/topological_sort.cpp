# include <bits/stdc++.h>

usuing namespace std;



class Graph
{
	int V;
	list<int> *adj;
	void toposortUtil(int v, int visited[], stack<int> &stack);
public:
	Graph(int v);
	void addedge(int u, int v);

	void toposort();

};

Graph :: Graph(int v)
{
	this->V = v;
	adj = new list<int>[V];

}


void Graph :: addedge(int u, int v)
{
	adj[u].push_back(v);
}


void Graph :: toposortUtil(int v, int visited[], stack<int>Stack)
{

	visited[v] = true;

	list<int>::iterator it;

	for(it=adj[v].begin(); it!= adj[v].end(); ++it)
	{
		if(!visited[*it])
			toposortUtil(*it, visited, Stack)
	}

	Stack.push(v);
}

void Graph:: toposort()
{
	bool *visited = new list<bool>[V];

	for(int i=0;i<V;i++)
		visited[i] = false;

	stack<int> Stack;

	list<int> :: iterator i;
	for(int i=0;i<V; i++)
	{
		if(!visited[*i])
			toposortUtil( i, visited, s)
	}

	while(Stack.empty() == false)
	{
		cout << Stack.top() << " ";
		Stack.pop();
	}

}

 //-------------------------------------------

int main(int argc, char const *argv[])
{

	Graph g(6);
	g.addedge(5,0);
	g.addedge(5,2);
	g.addedge(4,0);
	g.addedge(4,1);
	g.addedge(2,3);
	g.addedge(3,1);


	cout << " printing toposort" << endl;

	g.toposort();


	return 0;
}