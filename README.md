# HTTP-JSON-Bench.

Testing a tiny CRUD implementation in a various languages.

```
HTTP POST -> JSON Body -> {Person} > Add into mutable List<Person>
```

Benching with [Baton](https://github.com/americanexpress/baton).

```
baton -u http://localhost:3000 -c 1000 -r 1000000 -m POST -f test.json
```

## TODO.
* Currently unsafe writes.
* F# implementation fails to deserialize values.
* V refuses benchmark connections.

## #1. Crystal implementation.

```
Terminal 1: $ crystal build server.cr --release
            $ ./server
Terminal 2: [baton]

Time taken to complete requests:           327.4068ms
Requests per second:                        3 054 304
Max response time (ms):                            84
Min response time (ms):                             0
Avg response time (ms):                         35.13
```

## #2. OCaml implementation.

```
Terminal 1: $ dune build
            $ dune exec ./ocamlbench.exe
Terminal 2: $ [baton]

Time taken to complete requests:           376.8637ms
Requests per second:                        2 653 479
Max response time (ms):                            91
Min response time (ms):                             0
Avg response time (ms):                         22.97
```

## #3. F# implementation.

```
Terminal 1: $ dotnet build --configuration Release
            $ ./bin/Release/net5.0/fsharp.exe
Terminal 2: $ [baton]

All fields null? Will have to debug this one later.

Time taken to complete requests:           438.9992ms
Requests per second:                        2 277 908
Max response time (ms):                           120
Min response time (ms):                             6
Avg response time (ms):                         65.50
```

## #4. Go implementation.

```
Terminal 1: $ go run .
Terminal 2: [baton]

Time taken to complete requests:           628.9623ms
Requests per second:                        1 589 920
Max response time (ms):                           504
Min response time (ms):                             0
Avg response time (ms):                          9.86
```

## #5. V implementation.
```
Terminal 1: $ v .
            $ ./v.exe
Terminal 2: $ [baton]

apr_socket_recv: Transport endpoint is not connected (107)
```