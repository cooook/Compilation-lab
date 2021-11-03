%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void yyerror(const char *);
int yylex();

typedef struct astnode
{
     char operand[20];
     struct astnode *left;
     struct astnode *right;
}node;

node* makenode(const char rootname[20],node *left ,node *right);
void printtree (node *tree, int tab);
// void AST_print(node *t);
void printTabs(int numOfTabs);

%}
%union{
    char* varname;
    struct astnode *node;
}

%token<varname> ID NUM LESS_EQUAL_THAN LESS_THAN GREAT_THAN GREAT_EQUAL_THAN DOUBLE_EQUAL NOT_EQUAL
%token<varname> KEYWORD_ELSE KEYWORD_IF KEYWORD_INT KEYWORD_RETURN KEYWORD_VOID KEYWORD_WHILE
%type<varname> relop
%type<node> program declaration_list declaration var_declaration type_specifier fun_declaration params param_list param compound_stmt local_declarations statement_list
%type<node> statement expression_stmt selection_stmt iteration_stmt return_stmt expression var simple_expression additive_expression term factor call args arg_list
%left '+' '-'
%left '*' '/'
%expect 1


%%

program : declaration_list { $$ = makenode("program", $1, NULL); printtree($$,0); exit(0); }
        ;
declaration_list : declaration_list declaration
                 | declaration { $$ = makenode("declaration_list", $1, NULL); }
                 ;
declaration : var_declaration { $$ = $1; }
            | fun_declaration { $$ = $1; }
            ;
var_declaration : type_specifier ID ';' { $$ = makenode("var-declaration", $1, makenode($2, NULL, NULL)); }
                | type_specifier ID '[' NUM ']' ';'
                ;
type_specifier : KEYWORD_INT { $$ = makenode($1, NULL, NULL); }
               | KEYWORD_VOID { $$ = makenode($1, NULL, NULL); }
               ;
fun_declaration : type_specifier ID '(' params ')' compound_stmt { $$ = makenode("fun_declaration", $1, $6); }
                ;
params : param_list { $$ = $1; }
       | KEYWORD_VOID { $$ = makenode($1, NULL, NULL); }
       ;
param_list : param_list ',' param
           | param { $$ = $1; }
           ;
param : type_specifier ID
      | type_specifier ID '[' ']'
      ;
compound_stmt : '{' local_declarations statement_list '}' { $$ = makenode("compound_stmt", $2, $3); }
              ;
local_declarations : local_declarations var_declaration { $$ = makenode("local-declarations", $1, $2); }
                   | { $$ = makenode(" ", NULL, NULL); }
                   ;
statement_list : statement_list statement { $$ = makenode("statement_list", $1, $2); }
               | {}
               ;
statement : expression_stmt { $$ = $1; }
          | compound_stmt   { $$ = $1; }
          | selection_stmt  { $$ = $1; }
          | iteration_stmt  { $$ = $1; }
          | return_stmt     { $$ = $1; }
          ;
expression_stmt : expression ';' { $$=$1; }
                | ';' {}
                ;
selection_stmt : KEYWORD_IF '(' expression ')' statement {}
               | KEYWORD_IF '(' expression ')' statement KEYWORD_ELSE statement {}
               ;
iteration_stmt : KEYWORD_WHILE '(' expression ')' statement {}
               ;
return_stmt : KEYWORD_RETURN ';' { $$ = makenode("return", NULL, NULL); }
            | KEYWORD_RETURN expression ';' { }
            ;
expression : var '=' expression { $$ = makenode("=",$1,$3); }
           | simple_expression { $$ = $1; }
           ;
var : ID {  $$ = makenode($1,NULL,NULL); }
    | ID '[' expression ']' {  }
    ;
simple_expression : additive_expression relop additive_expression { }
                  | additive_expression { $$ = $1; }
                  ;
relop : LESS_EQUAL_THAN  { $$ = $1; }
      | LESS_THAN        { $$ = $1; }
      | GREAT_THAN       { $$ = $1; }
      | GREAT_EQUAL_THAN { $$ = $1; }
      | DOUBLE_EQUAL     { $$ = $1; }
      | NOT_EQUAL        { $$ = $1; }
      ;
additive_expression : additive_expression '+' term { $$ = makenode("+",$1,$3); }
                    | additive_expression '-' term { $$ = makenode("-",$1,$3); }
                    | term { $$ = $1; }
                    ;
term : term '*' factor { $$ = makenode("*",$1,$3); }
     | term '/' factor { $$ = makenode("/",$1,$3); }
     | factor { $$ = $1; }
     ;
factor : '(' expression ')' { $$ = $2; }
       | var { $$ = $1; }
       | call { $$ = $1; }
       | NUM { $$ = makenode($1,NULL,NULL); }
       ;
call : ID '(' args ')' {}
     ;
args : arg_list { $$ = $1; }
     | {}
     ;
arg_list : arg_list ',' expression
         | expression { $$ = $1; }
         ;
%%

node *makenode(const char* rootname,node *left, node *right )
{
	node *newnode = (node *)malloc(sizeof(node));
	strcpy(newnode->operand, rootname);
	newnode->left = left;
	newnode->right = right;
	return newnode;
}

void printtree (node* tree, int tab){
    int nextTab = tab;
    if (strlen(tree->operand) > 0) {
        printTabs(tab);
        printf ("|%s", tree->operand);
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
        printf("\n");
    }
    if (tree->right) {
        printtree(tree->right, tab + 1);
    }
}

// node* make_node(char* root, node* child1, node* child2)
// {
// 	node * node = (struct AST*)malloc(sizeof(struct AST));
// 	node->child = (struct AST**)malloc(2*sizeof(struct AST *));
// 	node->NumChild = 2;//
// 	strcpy(node->lexeme,root);
// 	node->child[0] = child1;
// 	node->child[1] = child2;
// 	return node;
// }

// void AST_print(node *t)
// {
// 	static int ctr=0;
// 	int i;
// 	if(t->NumChild==0)
// 		return;

// 	struct AST *t2=t;
// 	printf("\n%s  -->",t2->lexeme);
// 	for(i=0;i<t2->NumChild;++i)
// 	{
// 		printf("%s ",t2->child[i]->lexeme);
// 	}
// 	for(i=0;i<t2->NumChild;++i)
// 	{
// 		AST_print(t->child[i]);
// 	}
// }

void printTabs(int numOfTabs) {
    int i;
    for (i = 0; i < numOfTabs; i++) {
        // printf (i == numOfTabs - 1 ? "|  " : "  ");
        printf("|  ");
    }
}

int main() {
    yyparse();
}