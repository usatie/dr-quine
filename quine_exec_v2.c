#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#define QUINE_PRINT(code, i) dprintf(fd, code, i - 1, #code)

int main() {
    int i = 5;
    if (i < 0) return -1;
    char filename[100], exec_path[100], command[100];
    sprintf(filename, "quine_exec_%d.c", i);
	sprintf(exec_path, "quine_exec_%d", i);
    sprintf(command, "clang -Wall -Wextra -Werror %s -o %s", filename, exec_path);
    int fd = open(filename, O_CREAT | O_WRONLY, 0644);
    QUINE_PRINT(
        "#include <stdlib.h>\n"
        "#include <unistd.h>\n"
        "#include <fcntl.h>\n"
        "#include <stdio.h>\n"
        "#define QUINE_PRINT(code, i) dprintf(fd, code, i - 1, #code)\n"
        "int main() {\n"
        "    int i = %d;\n"
		"    if (i < 0) return -1;\n"
		"    char filename[100], exec_path[100], command[100];\n"
		"    sprintf(filename, \"quine_exec_%%d.c\", i);\n"
		"    sprintf(exec_path, \"quine_exec_%%d\", i);\n"
		"    sprintf(command, \"clang -Wall -Wextra -Werror %%s -o %%s\", filename, exec_path);\n"
        "    int fd = open(filename, O_CREAT | O_WRONLY, 0644);\n"
        "    QUINE_PRINT(%s, i);\n"
        "    close(fd);\n"
        "    system(command);\n"
		"    execv(exec_path, NULL);\n"
        "    return 0;\n"
        "}\n"
    , i);
    close(fd);
    system(command);
    execv(exec_path, NULL);
    return 0;
}
