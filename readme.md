# 基于 flex Bison 的 C-- 语言编译器

本项目是 NUAA 编译原理Ⅱ的课程实验。

注意点：
- 抽象语法树节点只有左右子树，还有很大的改进空间，只涉及少许语义分析。
- 符号表仅实现哈希表查找，更新，变量的行号与类型，变量的作用范围没有完成。

# 上手指南

## Software requirements

```
$ bison --version
bison (GNU Bison) 3.5.1
$ flex --version
flex 2.6.4
$ g++ --version
g++ (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
```

## lab1

用词法分析器 flex 解析源文件。

进入 lab1 目录，运行下列命令，会在终端输出解析结果。
```
clear && make clean && make run
```

## lab2

结合词法分析器 flex 与语法分析器 Bison 解析源文件。

进入 lab2 目录，运行下列命令，会在终端输出解析结果。
```
clear && make clean && make run
```

## lab3

在 lab2 的基础上加上了符号表的处理，做简单的变量存储与运算。

进入 lab3 目录，运行下列命令，会在终端输出符号表。
```
clear && make clean && make run
```

## lab4

在 lab2 的基础上加上了构建抽象语法树的功能。

进入 lab4 目录，运行下列命令，会在终端输出语法树。
```
clear && make clean && make run
```
## lab5

合并 lab3，lab4 的功能。

进入 lab5 目录，运行下列命令，会在终端输出语法树和符号表。
```
clear && make clean && make run
```
更多细节见：https://yym68686.top/flex-Bison-C-a5d93e95143248f1a0a31f7da102dad4
# Contributors
@yym68686
@cooook

# LICENSE

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see http://www.gnu.org/licenses/.