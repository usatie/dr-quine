#include <stdio.h>
/*
    This program will print its own source when run.
*/
int main() {
	/*
		Having source code in s, and inside the s, we have %s, which will be replaced by the s itself.
	*/
    char *s = "#include <stdio.h>%c"
		"/*%c"
		"    This program will print its own source when run.%c"
		"*/%c"
		"int main() {%c"
		"    /*%c"
        "        Having source code in s, and inside the s, we have %s, which will be replaced by the s itself.%c"
		"    */%c"
		"    char *s = %c%s%c;%c"
		"    printf(s, 10, 10, 10, 10, 10, 10, 10, 10, 34, s, 34, 10, 10, 10, 10);%c"
		"    return 0;%c"
		"}%c";
    printf(s, 10, 10, 10, 10, 10, 10, 10, 10, 34, s, 34, 10, 10, 10, 10);
    return 0;
}
