#include <stdio.h>
#define Q(x) int main() { char *s = #x; printf(x, s); }
Q("#include <stdio.h>\n#define Q(x) int main() { char *s = #x; printf(x, s); }\nQ(%s)\n")
