HELLO = hello
PRINTF = printf
COLLEEN = Colleen
GRACE = Grace
NAME = $(HELLO) $(PRINTF) $(COLLEEN) $(GRACE)
OBJS = $(NAME:=.o)

all: $(NAME)

run: $(NAME)
	./$(HELLO)

test: $(NAME)
	./$(COLLEEN) > tmp_Colleen.s && diff Colleen.s tmp_Colleen.s
	./$(GRACE) && diff Grace.s Grace_kid.s


%.o: %.s
	nasm -f elf64 -o $@ $<

$(HELLO): hello.o
	ld -o $@ $<

$(PRINTF): printf.o
	@# Linking with gcc to use printf
	gcc -o $@ $<

$(COLLEEN): Colleen.o
	gcc -o $@ $<

$(GRACE): Grace.o
	gcc -o $@ $<

clean:
	$(RM) $(OBJS)

fclean: clean
	$(RM) $(NAME)

re: fclean all
