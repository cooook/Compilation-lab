# 基于 flex Bison 的 C 语言编译器

本项目是 NUAA 编译原理Ⅱ的课程实验。

# 上手指南

## lab1

用词法分析器 flex 词法解析。

进入 lab1 目录，运行下列命令，会在终端输出解析结果。
```
clear && make clean && make run
```

## lab2

结合词法分析器 flex 与语法分析器 Bison 做词法解析。

进入 lab2 目录，运行下列命令，会在终端输出解析结果。
```
clear && make clean && make run
```

## lab3

在 lab2 的基础上加上了符号表的处理，做简单的变量存储与运算。

进入 lab3 目录，运行下列命令，会在终端输出符号表。
```
clear && make clean && make PARSER=SymbolList.y SCANNER=SymbolList.l run
```

## lab4

在 lab2 的基础上加上了构建抽象语法树的功能。

进入 lab4 目录，运行下列命令，会在终端输出语法树。
```
clear && make clean && make PARSER=AST.y SCANNER=AST.l run
```