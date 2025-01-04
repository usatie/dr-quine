HELLO = hello
PRINTF = printf
COLLEEN = Colleen
GRACE = Grace
SULLY = Sully
NAME = $(HELLO) $(PRINTF) $(COLLEEN) $(GRACE) $(SULLY)
OBJS = $(NAME:=.o)

all: $(NAME)

run: $(NAME)
	./$(HELLO)

test: $(NAME)
	./$(COLLEEN) > tmp_Colleen.s && diff Colleen.s tmp_Colleen.s
	./$(GRACE) && diff Grace.s Grace_kid.s
	./$(SULLY)
	ls -al | grep Sully | wc -l
	diff Sully.s Sully_0.s
	diff Sully_3.s Sully_2.s


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

$(SULLY): Sully.o
	gcc -o $@ $<

clean:
	$(RM) $(OBJS) Sully_* tmp_Colleen.s Grace_kid.s

fclean: clean
	$(RM) $(NAME)

re: fclean all
