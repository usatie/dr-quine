#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#define FILENAME(x) "quine_exec_" #x ".c"
#define QUINE_PRINT(code, x) dprintf(fd, code, x-1, #code, x-1, x-1, x-1, x-1, x-1)
int main() {
	int fd = open(FILENAME(5), O_CREAT|O_WRONLY, 0644);
	QUINE_PRINT("#include <stdlib.h>\n#include <unistd.h>\n#include <fcntl.h>\n#include <stdio.h>\n#define FILENAME(x) \"quine_exec_\" #x \".c\"\n#define QUINE_PRINT(code, x) dprintf(fd, code, x-1, #code, x-1, x-1, x-1, x-1, x-1)\nint main() {\n\tint fd = open(FILENAME(%d), O_CREAT|O_WRONLY, 0644);\n\tQUINE_PRINT(%s, %d);\n\tclose(fd);\n\tsystem(\"clang -Wall -Wextra -Werror \" FILENAME(%d) \" -o \" FILENAME(%d) \".out\");\n\tif (%d >= 0) execv(FILENAME(%d) \".out\", NULL);\n\treturn 0;\n}\n", 5);
	close(fd);
	system("clang -Wall -Wextra -Werror " FILENAME(5) " -o " FILENAME(5) ".out");
	if (5 >= 0) execv(FILENAME(5) ".out", NULL);
	return 0;
}
