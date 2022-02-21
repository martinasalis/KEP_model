/*********************************************
 * OPL 20.1.0.0 Model
 * Author: martinasalis
 * Creation Date: Feb 2, 2022 at 11:15:43 AM
 *********************************************/

tuple vertex
{
  	// type of node:
  	// - AD: altruistic donor
  	// - P: donor-patient pair
  	// - B: bridge donor
	string type;
	// delta_in = minus
	{int} delta_in;
	// delta_out = plus
	{int} delta_out;
}

// edges
{int} E = ...;

// vertices
{vertex} V = ...;

// weights of the edges
int w[E] = ...;

dvar float+ f_in[V];
dvar float+ f_out[V];
dvar int+ y[E];

maximize sum(e in E) (w[e] * y[e]);

subject to
{
	forall(v in V)
    	sum(e in v.delta_in)
			y[e] == f_in[v];
			
	forall(v in V)
    	sum(e in v.delta_out)
			y[e] == f_out[v];		

	forall(v in V)
	  	if(v.type == "P")
    		f_out[v] <= f_in[v];
    		
    forall(v in V)
	  	if(v.type == "P")
    		f_in[v] <= 1;
    		
    forall(v in V)
	  	if(v.type == "AD" || v.type == "B")
    		f_out[v] <= 1;
    
    forall(e in E)
      	y[e] == 0 || y[e] == 1;	
}
