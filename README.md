# ttl-hash

`TTL-Hash` is a simple hash table for caches with time-to-live key-value pairs.

- A key is a plain memory buffer (owned by the library).
- A value is an opaque pointer to a payload (owned by the application).

Two keys match when they have the exact same memory bytes.

Each key-value pair starts with a time-to-live counter (`ttl`), which is reset
after each retrieval.
An exposed tick function decrements all `ttls` at once.
When a `ttl` reaches `0`, its associated key-value pair is removed from the
table, and a registered callback may cleanup the value.

Notes about `TTL-Hash`:

- implemented as a single-header library
- uses the simple [DJB2][1] hashing algorithm
- it is not thread safe

[1]: https://en.wikipedia.org/wiki/List_of_hash_functions

# Example

- TODO
    - very simple abstract example which initializes a table, manipulates
      values in a loop calling the tick function
    - substitute <...>

```
#define TTL_HASH_C      // include implementation here
#include "ttl_hash"

// <open>
while (...) {
    ...
    // <get>
    ...
    // <add>
    ...
    // <tick>

}
// <close>
```

# API

- `typedef void (*cb_clean_t) (int n, const char* key, void* value)`
    - `cb_clean_t` is a function pointer type to cleanup callbacks.
        The callback is called whenever a key-value ttl expires.
    - Parameters:
        - `n: int` | key length
        - `key: char*` | key buffer
        - `value: void*` | value to clean

- `ttl_hash* ttl_hash_open (int n_buk, int n_ttl, cb_clean_t f)`
    - Creates a hash table with `n` buckets to hold entries.
    - Parameters:
        - `n_buk: int` | number of buckets
        - `n_ttl: int` | starting ttl for key-value pairs
        - `f: cb_clean_t` | cleanup callback for expired ttls
    - Return:
        - `ttl_hash*` | a pointer to the new hash table

- `void ttl_hash_close (ttl_hash* ht)`
    - Destroys a hash table, deallocating all existing entries.
        Calls the cleanup callback for each entry.
    - Parameters:
        - `ht: ttl_hash` | hash table to close
    - Return:
        - `void` | nothing

- `int ttl_hash_put (ttl_hash* ht, int n, const char* key, const void* value)`
    - Stores a key-value pair into the given hash table.
    - Parameters:
        - `ht: ttl_hash` | hash table to store
        - `n: int` | key length
        - `key: char*` | key buffer
        - `value: void*` | non-NULL value pointer
    - Return:
        - `int` | `0` on sucess
    - Notes:
        - The hash table owns the key, but not the value.
            It allocates, copies, and releases all key buffer bytes properly.
            It ignores the value pointer, only passing it to the cleanup
            callback eventually.
        - If the key already exists, the new value substitues the old, which
          is passed to the cleanup callback.
        - TODO: substitute with algorithm complexity

- `void* ttl_hash_get (ttl_hash* ht, int n, const char* key)`
    - Retrieves the value associated with the given hash table and key.
    - Parameters:
        - `ht: ttl_hash` | hash table to store
        - `n: int` | key length
        - `key: char*` | key buffer
    - Return:
        - `void*` | pointer to associated value (`NULL` if non existent)
    - Notes
        - TODO: substitute with algorithm complexity

- `int ttl_hash_rem (ttl_hash* ht, int n, const char* key)`
    - Removes the key-value pair associated with the given hash table and key.
    - Parameters:
        - `ht: ttl_hash` | hash table to remove
        - `n: int` | key length
        - `key: char*` | key buffer
    - Return:
        - `int` | `0` on success
    - Notes
        - The cleanup callback is called for the value.
        - TODO: substitute with algorithm complexity

- `void ttl_hash_tick (ttl_hash* ht)`
    - Decrements all key-value ttls at once, removing from the table those
      that reach `0`, and calling the cleanup callback for the value.
    - Parameters:
        - `ht: ttl_hash*`: hash table to tick
    - Return:
        - `void` | nothing
    - Notes
        - TODO: substitute with algorithm complexity
