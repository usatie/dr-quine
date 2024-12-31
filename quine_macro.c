#define Q(x) int main() { char *s = #x; __builtin_printf(x, s); }
Q("#define Q(x) int main() { char *s = #x; __builtin_printf(x, s); }\nQ(%s)\n")
