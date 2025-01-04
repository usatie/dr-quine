#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int i = 5;
#define QPRINT(self) dprintf(fd, self, i, REPR(self))
#define REPR(x) #x
#define SELF "#include <fcntl.h>\n#include <stdio.h>\n#include <stdlib.h>\n#include <unistd.h>\nint i = %d;\n#define QPRINT(self) dprintf(fd, self, i, REPR(self))\n#define REPR(x) #x\n#define SELF %s\nint main() {\n    char filename[100], exec_path[100], command[100];\n    --i;\n    sprintf(filename, \"Sully_%%d.c\", i);\n    sprintf(exec_path, \"Sully_%%d\", i);\n    sprintf(command, \"clang -Wall -Wextra -Werror %%s -o %%s\", filename, exec_path);\n    int fd = open(filename, O_CREAT | O_WRONLY, 0644);\n    QPRINT(SELF);\n    close(fd);\n    system(command);\n    if (i < 0) return -1;\n    char *argv[] = {NULL};\n    execv(exec_path, argv);\n    return 0;\n}\n"
int main() {
    char filename[100], exec_path[100], command[100];
    --i;
    sprintf(filename, "Sully_%d.c", i);
    sprintf(exec_path, "Sully_%d", i);
    sprintf(command, "clang -Wall -Wextra -Werror %s -o %s", filename, exec_path);
    int fd = open(filename, O_CREAT | O_WRONLY, 0644);
    QPRINT(SELF);
    close(fd);
    system(command);
    if (i < 0) return -1;
    char *argv[] = {NULL};
    execv(exec_path, argv);
    return 0;
}
