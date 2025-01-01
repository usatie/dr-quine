COLLEEN   = Colleen
GRACE     = Grace
SULLY     = Sully

NAME     = $(COLLEEN) $(GRACE) $(SULLY)
CC       = cc
CFLAGS   = -Wall -Wextra -Werror

all: $(NAME)

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
