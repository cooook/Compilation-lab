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

node *makenode(char operator1[20],node *left ,node *right);
void printtree (node *tree, int tab);
void printTabs(int numOfTabs);

%}
%union{
    char *varname;
    struct astnode *node;
}

%token<varname> ID NUM
%token LESS_EQUAL_THAN LESS_THAN GREAT_THAN GREAT_EQUAL_THAN DOUBLE_EQUAL NOT_EQUAL
%token KEYWORD_ELSE KEYWORD_IF KEYWORD_INT KEYWORD_RETURN KEYWORD_VOID KEYWORD_WHILE
%type<node> program declaration_list fun_declaration var_declaration declaration factor var type_specifier term expression simple_expression additive_expression
%left '+' '-'
%left '*' '/'
%expect 1


%%

program : declaration_list { }
        ;
declaration_list : declaration_list declaration
                 | declaration
                 ;
declaration : var_declaration
            | fun_declaration
            ;
var_declaration : type_specifier ID ';' { }
                | type_specifier ID '[' NUM ']' ';'
                ;
type_specifier : KEYWORD_INT {  }
               | KEYWORD_VOID { }
               ;
fun_declaration : type_specifier ID '(' params ')' compound_stmt { }
                ;
params : param_list {  }
       | KEYWORD_VOID { }
       ;
param_list : param_list ',' param
           | param
           ;
param : type_specifier ID
      | type_specifier ID '[' ']'
      ;
compound_stmt : '{' local_declarations statement_list '}'
              ;
local_declarations : local_declarations var_declaration
                   | {}
                   ;
statement_list : statement_list statement
               | {}
               ;
statement : expression_stmt
          | compound_stmt
          | selection_stmt
          | iteration_stmt
          | return_stmt
          ;
expression_stmt : expression ';' {  }
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
expression : var '=' expression {  }
           | simple_expression {  }
           ;
var : ID {  $$ = makenode($1,NULL,NULL); }
    | ID '[' expression ']' {  }
    ;
simple_expression : additive_expression relop additive_expression { }
                  | additive_expression {  }
                  ;
relop : LESS_EQUAL_THAN {}
      | LESS_THAN {}
      | GREAT_THAN {}
      | GREAT_EQUAL_THAN {}
      | DOUBLE_EQUAL {}
      | NOT_EQUAL {}
      ;
additive_expression : additive_expression '+' term { }
                    | additive_expression '-' term {  }
                    | term { }
                    ;
term : term '*' factor {}
     | term '/' factor {}
     | factor {}
     ;
factor : '(' expression ')' { }
       | var { }
       | call {  }
       | NUM {  }
       ;
call : ID '(' args ')'
     ;
args : arg_list { }
     | {}
     ;
arg_list : arg_list ',' expression
         | expression { }
         ;
%%

node *makenode(char* operator1,node *left, node *right )
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

int main() {
    yyparse();
}