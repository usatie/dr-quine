HELLO = hello
PRINTF = printf
COLLEEN = Colleen
NAME = $(HELLO) $(PRINTF) $(COLLEEN)
OBJS = $(NAME:=.o)

all: $(NAME)

run: $(NAME)
	./$(HELLO)

# Hello World
hello.o: hello.asm
	nasm -f elf64 -g -F DWARF -o $@ $<

$(HELLO): hello.o
	ld -o $@ $<

# Printf
printf.o: printf.asm
	nasm -f elf64 -o $@ $<

$(PRINTF): printf.o
	@# Linking with gcc to use printf
	gcc -o $@ $<

# Quine
Colleen.o: Colleen.S
	nasm -f elf64 -o $@ $<

$(COLLEEN): Colleen.o
	gcc -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all
