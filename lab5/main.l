%{
#include "y.tab.h"
void yyerror(const char *msg);
int left_BRACE, right_BRACE, left_parenthesis, right_parenthesis;
extern int whileflag, declared_error;
%}
%option yylineno
delim      [ \t]
letter     [a-zA-Z]
digit      [0-9]
id         {letter}{letter}*|{letter}{digit}*
NUM        {digit}{digit}*

%%
{delim}+                                        { printf("%s", yytext); }
"\n"|"\r\n"                                     { printf("%s", yytext); }
"{"                                             { left_BRACE++; printf("%s", yytext); yylval.varname = strdup(yytext); return yytext[0];}
"}"                                             { right_BRACE++; printf("%s", yytext); yylval.varname = strdup(yytext); return yytext[0];}
"("                                             { left_parenthesis++; printf("%s", yytext); yylval.varname = strdup(yytext); return yytext[0];}
")"                                             { right_parenthesis++; printf("%s", yytext); yylval.varname = strdup(yytext); return yytext[0];}
"["|"]"|";"|"/"|"*"|"-"|"+"|"="|","     { printf("%s", yytext); yylval.varname = strdup(yytext); return yytext[0];}
"else"                                          { printf("%s", yytext); yylval.varname = strdup(yytext); return KEYWORD_ELSE; }
"if"                                            { printf("%s", yytext); yylval.varname = strdup(yytext); return KEYWORD_IF; }
"int"                                           { printf("%s", yytext); yylval.varname = strdup(yytext); return KEYWORD_INT; }
"return"                                        { printf("%s", yytext); yylval.varname = strdup(yytext); return KEYWORD_RETURN; }
"void"                                          { printf("%s", yytext); yylval.varname = strdup(yytext); return KEYWORD_VOID; }
"while"                                         { printf("%s", yytext); yylval.varname = strdup(yytext); return KEYWORD_WHILE; }
"<"                                             { printf("%s", yytext); yylval.varname = strdup(yytext); return LESS_THAN; }
"<="                                            { printf("%s", yytext); yylval.varname = strdup(yytext); return LESS_EQUAL_THAN; }
">"                                             { printf("%s", yytext); yylval.varname = strdup(yytext); return GREAT_THAN; }
">="                                            { printf("%s", yytext); yylval.varname = strdup(yytext); return GREAT_EQUAL_THAN; }
"=="                                            { printf("%s", yytext); yylval.varname = strdup(yytext); return DOUBLE_EQUAL; }
"!="                                            { printf("%s", yytext); yylval.varname = strdup(yytext); return NOT_EQUAL; }
{id}                                            { printf("%s", yytext); yylval.varname = strdup(yytext); return ID; }
{NUM}                                           { printf("%s", yytext); yylval.varname = strdup(yytext); return NUM; }
"/*"[^*]*"*/"|"/*"[^*]*"*/"\n                                   { printf("%s", yytext); return MULTI_LINE_ANNOTATION; }
.                                               { printf("%s", yytext); return 0; }

%%

int yywrap(void) {
    return 1;
}
void yyerror(const char *msg) {
    if (whileflag){
        printf("\nline %d: error: %s\n", yylineno, msg);
        exit(1);
    }
    if (declared_error){
        printf("\nline %d: error: %s\n", yylineno, msg);
        exit(1);
    }
    if (left_parenthesis < right_parenthesis)
        msg = "'(' is missing on the inner loop.";
    else if (left_parenthesis > right_parenthesis)
        msg = "')' is missing on the inner loop.";
    else if (left_BRACE < right_BRACE)
        msg = "'{' is missing on the inner loop.";
    else if (left_BRACE > right_BRACE)
        msg = "'}' is missing on the inner loop.";
    else
        msg = "syntax error.";
    printf("\nline %d: error: %s\n", yylineno, msg);
    exit(1);
}