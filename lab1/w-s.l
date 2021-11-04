%{
enum TokenType
{
    QUOTATION               = 1001, // 单引号，'
    INTEGER                 = 1002, // 整数，123
    IDENTIFIER              = 1003, // 变量，adfa
    OPERATOR                = 1004, // 操作符，+/*
    KEYWORD                 = 1005, // 关键字，if/for
    L_PARENTHESIS           = 1006, // 左圆括号，(
    R_PARENTHESIS           = 1007, // 右圆括号，)
    L_SQUARE_BRACKET        = 1008, // 左方括号，[
    R_SQUARE_BRACKET        = 1009, // 右方括号，]
    L_BRACE                 = 1010, // 左大括号，{
    R_BRACE                 = 1011, // 右大括号，}
    QUESTION_SIGN           = 1012, // 问号，?
    COMMA                   = 1013, // 逗号，,
    COLON                   = 1014, // 冒号，:
    SEMICOLON               = 1015, // 分号，;
    POUND_SIGN              = 1016, // 井号，#
    LESS_THAN               = 1017, // 小于，<
    LESS_EQUAL_THAN         = 1018, // 小于等于，<=
    GREAT_THAN              = 1019, // 大于，>
    GREAT_EQUAL_THAN        = 1020, // 大于等于，>=
    DOUBLE_EQUAL            = 1021, // 等于 ==
    NOT_EQUAL               = 1022, // 不等于 !=
    EQUAL                   = 1023, // 赋值 =
    ANNOTATION              = 1024, // 单行注释，"
    MULTI_LINE_ANNOTATION   = 1025, // 多行注释，"

};
static char* token_strs[] = {
        "QUOTATION", "INTEGER", "IDENTIFIER", "OPERATOR", "KEYWORD", "L_PARENTHESIS", "R_PARENTHESIS", "L_SQUARE_BRACKET",
        "R_SQUARE_BRACKET", "L_BRACE", "R_BRACE", "QUESTION_SIGN", "COMMA",
        "COLON", "SEMICOLON", "POUND_SIGN", "LESS_THAN", "LESS_EQUAL_THAN", "GREAT_THAN",
        "GREAT_EQUAL_THAN", "DOUBLE_EQUAL", "NOT_EQUAL", "EQUAL", "ANNOTATION", "MULTI_LINE_ANNOTATION"
    };
%}

delim      [ \t\n]
letter     [a-zA-Z]
digit      [0-9]
id         {letter}{letter}*
NUM        {digit}{digit}*

%%
{delim}+                 {}
"else"                   { return KEYWORD; }
"if"                     { return KEYWORD; }
"int"                    { return KEYWORD; }
"return"                 { return KEYWORD; }
"void"                   { return KEYWORD; }
"while"                  { return KEYWORD; }
[*/+-]                   { return OPERATOR;}
"<"                      { return LESS_THAN; }
"<="                     { return LESS_EQUAL_THAN; }
">"                      { return GREAT_THAN; }
">="                     { return GREAT_EQUAL_THAN; }
"=="                     { return DOUBLE_EQUAL; }
"!="                     { return NOT_EQUAL; }
"="                      { return EQUAL; }
";"                      { return SEMICOLON; }
","                      { return COMMA; }
"("                      { return L_PARENTHESIS; }
")"                      { return R_PARENTHESIS; }
"["                      { return L_SQUARE_BRACKET; }
"]"                      { return R_SQUARE_BRACKET; }
"{"                      { return L_BRACE; }
"}"                      { return R_BRACE; }
{id}                     { return IDENTIFIER; }
{NUM}                    { return INTEGER; }
"//"[^\n]*\n             { return ANNOTATION; }
"/*"[^\n]*"*/"           { return ANNOTATION; }
"/*"[^*]*"*/"            { return MULTI_LINE_ANNOTATION; }
%%

int main() {
	int token;
	while (token = yylex()) {
		printf("%-20s", token_strs[token-1001]);
		puts(yytext);
	}
	return 0;
}

int yywrap() {
	return 1;
}


