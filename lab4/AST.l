%{
#include "y.tab.h"
void yyerror(const char *msg);
int linenumber = 1;
%}
%option yylineno
delim      [ \t]
letter     [a-zA-Z]
digit      [0-9]
id         {letter}{letter}*
NUM        {digit}{digit}*

%%
{delim}+                                        { printf("%s", yytext); }
"\n"|"\r\n"                                     { printf("%s", yytext); linenumber++; }
"{"|"}"|"["|"]"|"("|")"|";"|"/"|"*"|"-"|"+"|"=" { printf("%s", yytext); return yytext[0];}
"else"                                          { printf("%s", yytext); return KEYWORD_ELSE; }
"if"                                            { printf("%s", yytext); return KEYWORD_IF; }
"int"                                           { printf("%s", yytext); return KEYWORD_INT; }
"return"                                        { printf("%s", yytext); return KEYWORD_RETURN; }
"void"                                          { printf("%s", yytext); return KEYWORD_VOID; }
"while"                                         { printf("%s", yytext); return KEYWORD_WHILE; }
{id}                                            { printf("%s", yytext); return ID; }
{NUM}                                           { printf("%s", yytext); return NUM; }
.                                               { printf("%s", yytext); return 0; }

%%

int yywrap(void) {
    return 1;
}
void yyerror(const char *msg) {
    printf("\nline %d: error: %s\n", yylineno, msg);
    exit(1);
}