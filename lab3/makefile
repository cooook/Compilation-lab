CC = g++
OUT = calc
OBJ = lex.yy.o y.tab.o Symbol_table.o
SCANNER = calc.l
PARSER = calc.y

build: $(OUT)

run: $(OUT)
	./$(OUT) < test.c

clean:
	rm -f *.o lex.yy.c y.tab.c y.tab.h y.output $(OUT) test.asm

$(OUT): $(OBJ)
	$(CC) -o $(OUT) $(OBJ)

lex.yy.c: $(SCANNER) y.tab.c
	flex $<

y.tab.c: $(PARSER)
	bison -vdty -Wno-yacc $<

Symbol_table.o: Symbol_table.cpp
	$(CC) -c $<