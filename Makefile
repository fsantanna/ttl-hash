CC = gcc
CFLAGS = -Wall -Wextra -std=c99
VALGRIND = valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 -q

.PHONY: all clean tests hello tst/unit tst/app tst/bench

all: hello

hello: hello.c ttl_hash.h
	$(CC) $(CFLAGS) -o hello hello.c
	./hello

tests: tst/unit tst/app tst/bench

tst/unit: tst/unit.c ttl_hash.h
	$(CC) $(CFLAGS) -I. -o tst/unit tst/unit.c
	$(VALGRIND) ./tst/unit

tst/app: tst/app.c ttl_hash.h
	$(CC) $(CFLAGS) -I. -o tst/app tst/app.c
	$(VALGRIND) ./tst/app

tst/bench: tst/bench.c ttl_hash.h
	$(CC) $(CFLAGS) -I. -o tst/bench tst/bench.c
	$(VALGRIND) ./tst/bench

clean:
	rm -f hello tst/unit tst/app tst/bench
