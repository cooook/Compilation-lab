/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    NUM = 259,
    LESS_EQUAL_THAN = 260,
    LESS_THAN = 261,
    GREAT_THAN = 262,
    GREAT_EQUAL_THAN = 263,
    DOUBLE_EQUAL = 264,
    NOT_EQUAL = 265,
    KEYWORD_ELSE = 266,
    KEYWORD_IF = 267,
    KEYWORD_INT = 268,
    KEYWORD_RETURN = 269,
    KEYWORD_VOID = 270,
    KEYWORD_WHILE = 271
  };
#endif
/* Tokens.  */
#define ID 258
#define NUM 259
#define LESS_EQUAL_THAN 260
#define LESS_THAN 261
#define GREAT_THAN 262
#define GREAT_EQUAL_THAN 263
#define DOUBLE_EQUAL 264
#define NOT_EQUAL 265
#define KEYWORD_ELSE 266
#define KEYWORD_IF 267
#define KEYWORD_INT 268
#define KEYWORD_RETURN 269
#define KEYWORD_VOID 270
#define KEYWORD_WHILE 271

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 20 "AST.y"

    char *varname;
    struct astnode *node;

#line 94 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
