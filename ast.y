%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>

	extern int yylex();
	void yyerror(char *s);

	typedef struct astnode 
	{
		char operand[20];
		struct astnode *left; 
		struct astnode *right;
	}node;
	
	node *makenode(char operator1[20],node *left ,node *right);
	void printtree (node *tree, int tab);
void printTabs(int numOfTabs) ;
%}

%union	
{
	char  variable[20];
	struct astnode *node;
}

%start start 
%left '+' '-' 
%left '/' '*'
%type<node> start expr  
%token<variable> NUMBER ID

%%
start :  expr ';' { $$=$1; printtree($$,0); exit(0); }
expr : expr '+' expr  { $$ = makenode((char*)("+\0"),$1,$3); }
     | expr '-' expr  { $$ = makenode((char*)("-\0"),$1,$3);}
     | expr '*' expr  { $$ = makenode((char*)("*\0"),$1,$3);}
     | expr '/' expr  { $$ = makenode((char*)("/\0"),$1,$3);}
     | '(' expr ')'   { $$ = $2;		    }
     | NUMBER 	      { $$ = makenode($1,NULL,NULL); } 
     | ID	      { $$ = makenode($1,NULL,NULL); }
     ;
%%


node *makenode(char operator1[20],node *left, node *right )
{	
	node *newnode = (node *)malloc(sizeof(node));
	strcpy(newnode-> operand,operator1);
	newnode -> left = left;
	newnode -> right = right;
	return newnode; 	
}
void printtree (node *tree, int tab){
    int nextTab = tab;
    if (strlen(tree->operand) > 0) {
        printTabs(tab);
        printf ("(%s", tree->operand);
        if (tree->left != NULL) {
            printf("\n");
        }
    }
    if (tree->left) {
        if (strlen(tree->operand) == 0) {
            nextTab = tab - 1;
        }
        printtree(tree->left, nextTab + 1);
        if (strlen(tree->operand) > 0) {
            printTabs(tab);
        }
    }
    if (strlen(tree->operand) > 0) {
        printf (")\n");
    }
    if (tree->right) {
        printtree (tree->right, tab);
    }
}

void printTabs(int numOfTabs) {
    int i;
    for (i = 0; i < numOfTabs; i++) {
        printf ("\t");
    }
}



void yyerror(char *s)
{
printf("%s\n", s);
}

int main()
{     
	yyparse();
}

