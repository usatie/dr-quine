# Dr Quine
## Generate the data of the source code
Let assume that the source code is in a file named `Grace.s`, and the `src` variable is defined in the `.data` section and the value is an empty string.
```asm
global  main
extern  printf

section .data
    src   db  "", 0
...
```

The following command will generate the data of the source code.
```bash
$ ./gen.sh Grace.s
```

With the produced string, we can fill the `src` variable in the source code.
