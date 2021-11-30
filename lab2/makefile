CC = gcc
OUT = tcc
OBJ = lex.yy.o y.tab.o
SCANNER = my.l
PARSER = my.y
# TESTFILE = ../Tests/Test1/test1e.txt
TESTFILE = ../Tests/test2.c

build: $(OUT)

run: $(OUT)
	./$(OUT) < $(TESTFILE)

clean:
	rm -f *.o lex.yy.c y.tab.c y.tab.h y.output $(OUT) test.asm

$(OUT): $(OBJ)
	$(CC) -o $(OUT) $(OBJ)

lex.yy.c: $(SCANNER) y.tab.c
	flex $<

y.tab.c: $(PARSER)
	bison -vdty -Wno-yacc $<