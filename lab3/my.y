%{
# include <stdio.h>
# include <string.h>
void yyerror(const char*);
int yylex();
%}

%union{
    int intval;
    char* buffer;
}
%token<intval> T_NUM 
%token<buffer> T_ID
%token RIGHT_COMMENT LEFT_COMMENT T_KEYWORD_IF T_KEYWORD_ELSE T_KEYWORD_INT T_KEYWORD_RETURN T_KEYWORD_VOID T_KEYWORD_WHILE 
%token T_EQ T_NE T_LE T_GE
%left '+' '-'
%left '*' '/'
%start program
%expect 12

%type<intval>factor;

%%

addop   :   '+' {printf("+");}
        |   '-' {printf("-");}
        ;

mulop   :   '*' {printf("*");}
        |   '/' {printf("/");}
        ;
relop   :   '<'     { }
        |   '>'     { printf("There >\n"); }
        |   T_LE    { }
        |   T_GE    { printf("there\n"); }
        |   T_EQ    { }
        |   T_NE    { }
        ;

arg_list    : arg_list ',' expression { }
            | expression              { }
            ;

args        : arg_list    {  }
            | /* empty */ { /* empty */ }
            ;

call        : T_ID '(' args ')'     {printf("call success");}
            ;

factor  :   '(' expression ')' { }
        | var                  { }
        | call                 { }
        | T_NUM                { printf("number = %d\n", $1); }
        ;

term    : term mulop factor { }
        | factor            { printf("term = %d\n", $1); }
        ;

additive_expression     : additive_expression addop term { }
                        | term                           { }
                        ;

simple_expression       : additive_expression relop additive_expression { }
                        | additive_expression   { }
                        ;

var     : T_ID { printf("%s", $1); }
        | T_ID '[' expression ']' { }
        ;

expression  : var '=' expression    { }
            |   simple_expression   { }
            ;

return_stmt : T_KEYWORD_RETURN ';' { }
            | T_KEYWORD_RETURN expression ';' { }
            ;

iteration_stmt  :   T_KEYWORD_WHILE '(' expression ')' statement { }
                ;

selection_stmt  : T_KEYWORD_IF '(' expression ')' statement { }
                | T_KEYWORD_IF '(' expression ')' statement T_KEYWORD_ELSE statement { printf("IF!\n"); }
                ;

expression_stmt : expression ';' { }
                | ';'            { }
                ;

statement   : expression_stmt { }
            | compound_stmt {   }
            | selection_stmt { }
            | iteration_stmt { }
            | return_stmt { }
            ;

statement_list  : statement_list statement { }
                | /* empty */ { }
                ;

local_declarations  : local_declarations var_declaration { }
                    | /* empty */ { }
                    ;

compound_stmt_list  :   compound_stmt_list local_declarations statement_list { }
                    |   /* empty */ { }
                    ;

compound_stmt   : '{' compound_stmt_list '}' { }
                ;

param   : type_specifier T_ID { }
        | type_specifier T_ID '[' ']' { }
        ;

param_list  : param_list ',' param { }
            | param     { }
            ;

params  : param_list { }
        | T_KEYWORD_VOID { }
        | { }
        ;

fun_declaration     : type_specifier T_ID '(' params ')' compound_stmt { }
                    ;

type_specifier  : T_KEYWORD_INT   { printf("KEYWORD_INT\n"); }
                | T_KEYWORD_VOID  { }
                ;

var_declaration : type_specifier T_ID ';' { }
                | type_specifier T_ID '[' T_NUM ']' ';' { }
                | type_specifier T_ID '=' expression ';' { }
                ;

declaration     : var_declaration { }
                | fun_declaration { }
                ;

declaration_list    : declaration_list declaration { }
                    | declaration { }
                    ;

program : declaration_list { printf("Parse Over!"); }
        ;
%%

int main() {
    return yyparse();
}