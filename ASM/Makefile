HELLO = hello
PRINTF = printf
COLLEEN = Colleen
NAME = $(HELLO) $(PRINTF) $(COLLEEN)
OBJS = $(NAME:=.o)

all: $(NAME)

run: $(NAME)
	./$(HELLO)

%.o: %.s
	nasm -f elf64 -o $@ $<

$(HELLO): hello.o
	ld -o $@ $<

$(PRINTF): printf.o
	@# Linking with gcc to use printf
	gcc -o $@ $<

$(COLLEEN): Colleen.o
	gcc -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all
