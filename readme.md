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

# Contributors
@yym68686
@cooook

# LICENSE

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see http://www.gnu.org/licenses/.