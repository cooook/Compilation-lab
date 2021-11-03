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

program : declaration_list { $$=$1; printtree($$,0); exit(0); }
        ;
declaration_list : declaration_list declaration
                 | declaration { $$ = $1; }
                 ;
declaration : var_declaration { $$ = $1; }
            | fun_declaration { $$ = $1; }
            ;
var_declaration : type_specifier ID ';' {  }
                | type_specifier ID '[' NUM ']' ';'
                ;
type_specifier : KEYWORD_INT { $$ = makenode($1, NULL, NULL); }
               | KEYWORD_VOID { $$ = makenode($1, NULL, NULL); }
               ;
fun_declaration : type_specifier ID '(' params ')' compound_stmt {  }
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
compound_stmt : '{' local_declarations statement_list '}' { $$=$3; }
              ;
local_declarations : local_declarations var_declaration
                   | {}
                   ;
statement_list : statement_list statement { $$=$2; }
               | {}
               ;
statement : expression_stmt { $$ = $1; }
          | compound_stmt   { $$ = $1; }
          | selection_stmt  { $$ = $1; }
          | iteration_stmt  { $$ = $1; }
          | return_stmt     { $$ = $1; }
          ;
expression_stmt : expression ';' { $$=$1; }
                | ';'
                ;
selection_stmt : KEYWORD_IF '(' expression ')' statement
               | KEYWORD_IF '(' expression ')' statement KEYWORD_ELSE statement
               ;
iteration_stmt : KEYWORD_WHILE '(' expression ')' statement
               ;
return_stmt : KEYWORD_RETURN ';' {}
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
call : ID '(' args ')'
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

int main() {
    yyparse();
}