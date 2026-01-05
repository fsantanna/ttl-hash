CC = gcc
CFLAGS = -Wall -Wextra -std=c99

.PHONY: all clean test hello tst/unit tst/app

all: hello test

hello: hello.c ttl_hash.h
	$(CC) $(CFLAGS) -o hello hello.c
	./hello

test: tst/unit tst/app

tst/unit: tst/unit.c ttl_hash.h
	$(CC) $(CFLAGS) -I. -o tst/unit tst/unit.c
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 -q ./tst/unit

tst/app: tst/app.c ttl_hash.h
	$(CC) $(CFLAGS) -I. -o tst/app tst/app.c
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 -q ./tst/app

clean:
	rm -f hello tst/unit tst/app
