run: w-s
	./w-s < test.c

clean:
	rm -f lex.yy.c w-s

w-s: lex.yy.c
	gcc -o $@ $<

lex.yy.c: w-s.l
	flex $<