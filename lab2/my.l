%{
# include <stdio.h>
# include <string.h>
# include "y.tab.h"
# define BRACKETS_ERROR 1
# define COMMENT_ERROR 2
int flag = 0;
int comment = 0;
int cur_line = 1;
void unrecognized_char(char c);
void yyerror(const char *msg);

%}


KEY \<|\>|=|,|\+|\-|\*|\/|;
NUM ([0-9]+)
ID ([_a-zA-Z][_a-zA-Z0-9]*)
WHITESPACE ([ \t]*)
%%
"\n"|"\r\n" {cur_line ++; printf("end of line\n");}
"if" { return T_KEYWORD_IF; }
"{"|"}"|"["|"]"|"("|")" { return yytext[0];}
"else" { return T_KEYWORD_ELSE; }
"int" { printf("%s\n", yytext); return T_KEYWORD_INT; }
"return" { return T_KEYWORD_RETURN; }
"void" { return T_KEYWORD_VOID;}
"while" { return T_KEYWORD_WHILE; }
{KEY} {printf("%c\n", yytext[0]); return yytext[0];}
"<=" {return T_LE;}
">=" {return T_GE;}
"!=" {return T_NE;}
"==" {return T_EQ;}
{ID}  { yylval.buffer = strdup(yytext); return T_ID;}
{NUM} {yylval.intval = atoi(yytext); printf("%d\n", yylval.intval); return T_NUM;}
{WHITESPACE} {/* ignore every whitespcace */}

"/*" {
    if (comment == 0)
        comment = 1;
    else
        flag |= COMMENT_ERROR;
    printf("%s\n", yytext);
    return LEFT_COMMENT;
}
"*/" {
    if (comment != 1)
        flag |= COMMENT_ERROR;
    else
        comment = 0;
    return RIGHT_COMMENT;
}
. {unrecognized_char(yytext[0]);}
%%
int yywrap(){
    return 1;
}

void unrecognized_char(char c) {
    char buf[32] = "Unrecognized character: ?";
    buf[24] = c;
    yyerror(buf);
}

void yyerror(const char *msg) {
    printf("Error at line %d:\n\t%s\n", cur_line, msg);
    exit(1);
}