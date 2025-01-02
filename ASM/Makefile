HELLO = hello
NAME = $(HELLO)
OBJS = $(NAME:=.o)

all: $(HELLO)

run: $(HELLO)
	./$(HELLO)

hello.o: hello.asm
	nasm -f elf64 -g -F DWARF -o $@ $<

$(HELLO): hello.o
	ld -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all
