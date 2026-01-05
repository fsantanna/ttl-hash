# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TTL-Hash is a single-header C library implementing a hash table with time-to-live key-value pairs, designed for caching use cases. See README.md for the full API specification.

## Build Commands

This is a single-header library. To use:

```c
#define TTL_HASH_C      // include implementation (in ONE .c file only)
#include "ttl_hash"
```

Compile tests with:

```bash
gcc -o unit unit.c
gcc -o app app.c
```

## Code Style

- Comments only before blocks or functions, never inline
- If lines require comments, create an explicit block for them
- Single-header library pattern: header guards for declarations, `#ifdef TTL_HASH_C` for implementation
