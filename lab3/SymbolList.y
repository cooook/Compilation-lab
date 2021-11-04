%{
#include <stdio.h>
#include <string.h>
#include "Symbol_table.h"
void yyerror(const char *);
Hash_Table Symbol_Table;
extern int yylineno;
int yylex();

typedef struct astnode
{
     char operand[20];
     struct astnode *left;
     struct astnode *right;
}node;


%}
%union{
    int intval;
    char *varname;
}

%token<intval> NUM
%token<varname> ID
%token LESS_EQUAL_THAN LESS_THAN GREAT_THAN GREAT_EQUAL_THAN DOUBLE_EQUAL NOT_EQUAL
%token KEYWORD_ELSE KEYWORD_IF KEYWORD_INT KEYWORD_RETURN KEYWORD_VOID KEYWORD_WHILE
%type <intval> term factor expression simple_expression additive_expression
%type <varname> var type_specifier
%left '+' '-'
%left '*' '/'
%expect 1


%%

program : declaration_list
        ;
declaration_list : declaration_list declaration
                 | declaration
                 ;
declaration : var_declaration
            | fun_declaration
            ;
var_declaration : type_specifier ID ';' {  Symbol_Table[$2]->line_number = yylineno; Symbol_Table[$2]->type = $1; }
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
expression : var '=' expression { Symbol_Table[$1]->Value = $3; }
           | simple_expression { $$ = $1; }
           ;
var : ID { Symbol_Table[$$]->Value = Symbol_Table[$1]->Value; }
    | ID '[' expression ']' {  }
    ;
simple_expression : additive_expression relop additive_expression { }
                  | additive_expression { $$ = $1; }
                  ;
relop : LESS_EQUAL_THAN {}
      | LESS_THAN {}
      | GREAT_THAN {}
      | GREAT_EQUAL_THAN {}
      | DOUBLE_EQUAL {}
      | NOT_EQUAL {}
      ;
additive_expression : additive_expression '+' term { $$ = $1 + $3; }
                    | additive_expression '-' term { $$ = $1 - $3; }
                    | term { $$ = $1; }
                    ;
term : term '*' factor { $$ = $1 * $3; }
     | term '/' factor { if (($3) != 0 )
                              $$ = $1 / $3;
                         else
                              yyerror("divide by zero");
                       }
     | factor { $$ = $1;}
     ;
factor : '(' expression ')' { $$ = $2; }
       | var { $$ = Symbol_Table[$1]->Value; }
       | call {  }
       | NUM { $$ = $1; }
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

int main() {
    yyparse();
    Symbol_Table.printTable();
    return 0;
}