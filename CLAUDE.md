# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TTL-Hash is a single-header C library implementing a hash table with time-to-live key-value pairs, designed for caching use cases. See README.md for the full API specification.

## Project Structure

- `ttl_hash.h` - Single-header library (header + implementation)
- `hello.c` - Minimal usage example
- `tst/unit.c` - Unit tests for all APIs
- `tst/app.c` - Session cache simulation demonstrating recurrent usage
- `Makefile` - Build configuration

## Build Commands

This is a single-header library. To use:

```c
#define TTL_HASH_C      // include implementation (in ONE .c file only)
#include "ttl_hash.h"
```

Build using Makefile:

```bash
make           # build everything (hello + tests)
make hello     # build hello example
make test      # build tests (tst/unit and tst/app)
make clean     # remove all binaries
```

Or compile manually:

```bash
gcc -Wall -Wextra -o hello hello.c
gcc -Wall -Wextra -I. -o tst/unit tst/unit.c
gcc -Wall -Wextra -I. -o tst/app tst/app.c
```

## Code Style

- Comments only before blocks or functions, never inline
- If lines require comments, create an explicit block for them
- Single-header library pattern: header guards for declarations, `#ifdef TTL_HASH_C` for implementation
