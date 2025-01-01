#include <stdio.h>
/*
    This program will print its own source when run.
*/
void print_source() {
    /*
        Having source code in s, and inside the s, we have %s, which will be replaced by the s itself. newline(10), double quote(34)
    */
    char *s = "#include <stdio.h>%c/*%c    This program will print its own source when run.%c*/%cvoid print_source() {%c    /*%c        Having source code in s, and inside the s, we have %%s, which will be replaced by the s itself. newline(10), double quote(34)%c    */%c    char *s = %c%s%c;%c    printf(s, 10, 10, 10, 10, 10, 10, 10, 10, 34, s, 34, 10, 10, 10, 10, 10, 10);%c}%cint main() {%c    print_source();%c}%c";
    printf(s, 10, 10, 10, 10, 10, 10, 10, 10, 34, s, 34, 10, 10, 10, 10, 10, 10);
}
int main() {
    print_source();
}
