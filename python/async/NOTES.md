# Async Python

## Async IO

Async IO is lesser known that multiprocessing and threading

> “Use async IO when you can; use threading when you must.”

Async IO is a programming pattern that enables concurrent execution of I/O-bound tasks without
using threads or multiprocessing. It's particularly useful for applications that deal with many
network connections or file operations.

Key features of Async IO include:

- Non-blocking execution: Tasks can be paused and resumed, allowing other tasks to run in the meantime.
- Single-threaded concurrency: Async IO typically runs on a single thread, avoiding the complexities of multi-threading.
  Event loop: An event loop manages the execution of coroutines and handles I/O operations.

Async IO shines when you have multiple IO-bound tasks where the tasks would otherwise be dominated
by blocking IO-bound wait time, such as:

- Network IO, whether your program is the server or the client side
- Serverless designs, such as a peer-to-peer, multi-user network like a group chatroom
- Read/write operations where you want to mimic a “fire-and-forget” style but worry less about holding a lock on whatever you’re reading and writing to

## Libraries That Work with `async/await`

- `aiohttp`: Asynchronous HTTP client/server framework
- `aioredis`: Async IO Redis support
- `aiopg`: Async IO PostgreSQL support
- `aiomcache`: Async IO memcached client
- `aiokafka`: Async IO Kafka client
- `aiozmq`: Async IO ZeroMQ support
- `aiojobs`: Jobs scheduler for managing background tasks
- `async_lru`: Simple LRU cache for async IO
- `uvloop`: Ultra fast async IO event loop
- `asyncpg`: (Also very fast) async IO PostgreSQL support
- `trio`: Friendlier asyncio intended to showcase a radically simpler design
- `aiofiles`: Async file IO
- `asks`: Async requests-like http library
- `asyncio-redis`: Async IO Redis support
- `aioprocessing`: Integrates multiprocessing module with asyncio
- `umongo`: Async IO MongoDB client
- `unsync`: Unsynchronize asyncio
- `aiostream`: Like itertools, but async
