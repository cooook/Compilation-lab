%{
	#include<stdio.h>
	#include <string.h>
	#include "y.tab.h"
%}

%%
([a-z]|[A-Z])([a-z]|[A-Z]|_|[0-9])*	{   strcpy(yylval.variable , yytext);  return ID ;	}
[0-9]+		{	strcpy(yylval.variable,yytext); return NUMBER;	}
[+|\-|*|/|\(|\)|;]	{ return *yytext ; }
\n	              { return('\n'); }
%%

int yywrap()
{
	return 1;
}
