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
