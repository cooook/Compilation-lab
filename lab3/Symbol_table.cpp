# include <bits/stdc++.h>



struct Infomation {
    char *Identifier; // 该符号名
    char type[0x10]; // 符号对应的类型
    int Value;     // 该符号对应的值
    int line_number;    // 定义所在的行号
    
    Information(char *s) {
        Identifier = strdup(s);
    }
    ~Information() { free(Identifier); Identifier = NULL; }
    bool Equ(const char* a) {
        return strcmp(Identifier, a) == 0;
    }
};

class Hash_Table {
public:
    const int KEY = 76543; 
    const int P = 107;
    int first[KEY], e; 
    struct Entry{
        unsigned long long Hash;
        Infomation *info; 
        int next;
        ~Info() { free(info); info = NULL; }
    } a[KEY];


    unsigned long long Get_Hash(const char* Identifier) {
        unsigned long long Ans = 0;
        for (int i = 0; Identifier[i]; ++i)
            Ans = Ans * P + Identifier[i];
        return Ans; 
    }

    Infomation& New_Entry(const char* Identifier, unsigned long long Hash) {
        a[++e].Hash = Hash; 
        a[e].info = new Infomation(Identifier);
        a[e].next = first[Hash % KEY];
        return a[e].info;
    }

    Infomation& operator [] (const char * Identifier) {
        unsigned long long Hash = Get_Hash(Identifier);
        for (int i = first[Hash % KEY]; i; i = a[i].next)
            if (a[i].info && a[i].info -> Equ(Identifier))
                return a[i].info;
        return New_Entry(Identifier, Hash);
    }

    bool Count(const char* Identifier) {
        unsigned long long Hash = Get_Hash(Identifier);
        for (int i = first[Hash % KEY]; i; i = a[i].next)
            if (a[i].info && a[i].info -> Equ(Identifier))
                return true;
        return false; 
    }
} Symbol_Table;

int main() {
    return 0; 
}