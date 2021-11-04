run: w-s
	./w-s < ../Tests/Test1/test1.txt

clean:
	rm -f lex.yy.c w-s

w-s: lex.yy.c
	gcc -o $@ $<

lex.yy.c: w-s.l
	flex $<