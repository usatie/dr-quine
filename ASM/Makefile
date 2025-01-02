HELLO = hello
PRINTF = printf
QUINE = quine
NAME = $(HELLO) $(PRINTF) $(QUINE)
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
quine.o: quine.asm
	nasm -f elf64 -o $@ $<

$(QUINE): quine.o
	gcc -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all
