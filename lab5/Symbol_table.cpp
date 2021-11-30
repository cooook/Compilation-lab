#include <bits/stdc++.h>
#include "Symbol_table.h"


struct Entry a[KEY];
unsigned long long Symbol_List[KEY];
int head = 0;

Information::Information(char *s) {
    Identifier = strdup(s);
}
Information::~Information() { free(Identifier); Identifier = NULL; }
bool Information::Equ(char* a) {
    return strcmp(Identifier, a) == 0;
}

Entry::Entry() { }
Entry::~Entry() { delete info; info = NULL; }

unsigned long long Hash_Table::Get_Hash(char* Identifier) {
    unsigned long long Ans = 0;
    for (int i = 0; Identifier[i]; ++i)
        Ans = Ans * P + Identifier[i];
    return Ans;
}

Information*& Hash_Table::New_Entry(char* Identifier, unsigned long long Hash) {
        int nowindex = first[Hash % KEY];
        Symbol_List[head++] = Hash % KEY;
        while(a[nowindex].next != 0) nowindex = a[nowindex].next;
        if (first[Hash % KEY] == 0) {
            first[Hash % KEY] = ++e;
            a[e].next = 0;
        }
        else
            a[nowindex].next = ++e;
        a[e].Hash = Hash;
        a[e].info = new Information(Identifier);
        return a[e].info;
}

Information*& Hash_Table::operator [] (char * Identifier) {
        unsigned long long Hash = Get_Hash(Identifier);
        for (int i = first[Hash % KEY]; i; i = a[i].next)
            if (a[i].info && a[i].info -> Equ(Identifier))
                return a[i].info;
        return New_Entry(Identifier, Hash);
}

bool Hash_Table::Count(char* Identifier) {
    unsigned long long Hash = Get_Hash(Identifier);
    for (int i = first[Hash % KEY]; i; i = a[i].next)
        if (a[i].info && a[i].info -> Equ(Identifier))
            return true;
    return false;
}

void Hash_Table::printTable() {
    printf("\n+-------------------------------------------+\n");
      printf("|                Symbol Table               |\n");
      printf("+----------+----------+----------+----------+\n");
      printf("|  Symbol  |   Value  |   Line   |   Type   |\n");
      printf("+----------+----------+----------+----------+\n");
    for(int i; i < head; i++){
        for (unsigned long long j = first[Symbol_List[i]]; j; j = a[j].next){
            printf("|%9s |%9d |%9d |%9s |\n", a[j].info->Identifier, a[j].info->Value, a[j].info->line_number, a[j].info->type);
            printf("+----------+----------+----------+----------+\n");

        }
    }
}
