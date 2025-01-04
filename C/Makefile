COLLEEN   = Colleen
GRACE     = Grace
SULLY     = Sully

NAME     = $(COLLEEN) $(GRACE) $(SULLY)
CC       = cc
CFLAGS   = -Wall -Wextra -Werror

all: $(NAME)

test: $(NAME)
	./$(COLLEEN) > tmp_Colleen.c && diff Colleen.c tmp_Colleen.c
	./$(GRACE) && diff Grace.c Grace_kid.c
	./$(SULLY)
	ls -al | grep Sully | wc -l
	diff Sully.c Sully_0.c
	diff Sully_3.c Sully_2.c

$(COLLEEN): Colleen.c
	$(CC) $(CFLAGS) -o $@ $<

$(GRACE): Grace.c
	$(CC) $(CFLAGS) -o $@ $<

$(SULLY): Sully.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(NAME:=.o) Grace_kid.c Sully_*

fclean: clean
	$(RM) $(NAME)

re: fclean all
