#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
/*
    This program will write its own source code to file named "Grace_kid.c" when run.
*/
#define FT(x) int main() { int fd = open("Grace_kid.c", O_CREAT | O_WRONLY, 0644); dprintf(fd, x, REPR(x)); close(fd); }
#define SELF "#include <fcntl.h>\n#include <stdio.h>\n#include <unistd.h>\n/*\n    This program will write its own source code to file named \"Grace_kid.c\" when run.\n*/\n#define FT(x) int main() { int fd = open(\"Grace_kid.c\", O_CREAT | O_WRONLY, 0644); dprintf(fd, x, REPR(x)); close(fd); }\n#define SELF %s\n#define REPR(x) #x\nFT(SELF)\n"
#define REPR(x) #x
FT(SELF)
