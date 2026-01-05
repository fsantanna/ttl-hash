#include <stdio.h>

#define TTL_HASH_C
#include "ttl_hash.h"

int main(void) {
    ttl_hash* ht = ttl_hash_open(16, 3, NULL);

    int value1 = 42;
    int value2 = 99;

    ttl_hash_put(ht, 5, "hello", &value1);
    ttl_hash_put(ht, 5, "world", &value2);

    int* v = (int*)ttl_hash_get(ht, 5, "hello");
    printf("hello = %d\n", *v);

    ttl_hash_tick(ht);
    ttl_hash_tick(ht);
    ttl_hash_tick(ht);

    if (ttl_hash_get(ht, 5, "hello") == NULL) {
        printf("hello expired\n");
    }

    ttl_hash_close(ht);
    return 0;
}
