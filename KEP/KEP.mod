/*********************************************
 * OPL 20.1.0.0 Model
 * Author: martinasalis
 * Creation Date: Feb 2, 2022 at 11:15:43 AM
 *********************************************/

tuple delta
{
  	// archi uscenti
	{string} delta_p;
	// archi entranti
	{string} delta_m;
}

// edge
{string} E = {"1", "2", "3"};

tuple pair
{
	string donator;
	string patient;
}

tuple vertex
{
	string type;
	delta d;
	// NDD -> donatori non diretti AD + B
	// donatori altruisti
	string AD;
	// donatori ponte
	string B;
	// coppie donatore-paziente non compatibili
	pair P;
}

{vertex} V;

// pesi edge
int w[E];

int f_in[V];
int f_out[V];

 
dvar int+ y[E];

maximize sum(e in E) (w[e] * w[e]);

subject to
{
	forall(v in V)
    	sum(e in v.d.delta_m)
			y[e] == f_in[v];
			
	forall(v in V)
    	sum(e in v.d.delta_p)
			y[e] == f_out[v];		

	forall(v in V)
	  	if(v.type == "P")
    		f_out[v] <= f_in[v] <= 1;
    		
    forall(v in V)
	  	if(v.type == "AD" || v.type == "B")
    		f_out[v] <= 1;
    
    forall(e in E)
      	y[e] == 0 || y[e] == 1;	
}
