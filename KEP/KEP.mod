/*********************************************
 * OPL 20.1.0.0 Model
 * Author: martinasalis
 * Creation Date: Feb 2, 2022 at 11:15:43 AM
 *********************************************/

// uno dei due è 0, è valido quello diverso da 0
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
	string AD;
	string B;
	pair P;
}


/* uno dei due è 0, è valido quello diverso da 0
tuple donator
{
	// donatori altruisti
	string AD;
	// donatori ponte
	string B;
	int flag;
}

// uno dei due (N o P) è 0, è valido quello diverso da 0
tuple vertex
{
	// NDD -> donatori non diretti
	donator N;
	// coppie donatore-paziente non compatibili
	string P;
	delta d;
	int flag;
}
*/

{vertex} V;

// pesi edge
int w[E];

int f_in[V];
int f_out[V];

maximize sum(e in E) (w[e] * w[e]);
 
dvar int+ y[E];