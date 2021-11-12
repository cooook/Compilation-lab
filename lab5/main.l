%{
#include "y.tab.h"
void yyerror(const char *msg);
%}
%option yylineno
delim      [ \t]
letter     [a-zA-Z]
digit      [0-9]
id         {letter}{letter}*
NUM        {digit}{digit}*

%%
{delim}+                                        { printf("%s", yytext); }
"\n"|"\r\n"                                     { printf("%s", yytext); }
"{"|"}"|"["|"]"|"("|")"|";"|"/"|"*"|"-"|"+"|"=" { printf("%s", yytext); yylval.varname = strdup(yytext); return yytext[0];}
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
"/*"[^*]*"*/"                                   { printf("%s", yytext); return MULTI_LINE_ANNOTATION; }
.                                               { printf("%s", yytext); return 0; }

%%

int yywrap(void) {
    return 1;
}
void yyerror(const char *msg) {
    printf("\nline %d: error: %s\n", yylineno, msg);
    exit(1);
}