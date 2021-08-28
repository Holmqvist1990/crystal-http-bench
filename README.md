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
* ~~Currently unsafe writes.~~
* ~~F# implementation fails to deserialize values.~~
* V refuses benchmark connections.

## #1. Crystal implementation.

```
Terminal 1: $ crystal build server.cr --release
            $ ./server
Terminal 2: [baton]

Time taken to complete requests:           327.3433ms
Requests per second:                          3054897
Max response time (ms):                           117
Min response time (ms):                             0
Avg response time (ms):                         28.11
```

## #2. F# implementation.

```
Terminal 1: $ dotnet build --configuration Release
            $ ./bin/Release/net5.0/fsharp.exe
Terminal 2: $ [baton]

Time taken to complete requests:           372.7315ms
Requests per second:                          2682896
Max response time (ms):                           134
Min response time (ms):                             0
Avg response time (ms):                         83.35
```

## #3. OCaml implementation.

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

## #4. Go implementation.

```
Terminal 1: $ go run .
Terminal 2: [baton]

Time taken to complete requests:           607.2148ms
Requests per second:                          1646864
Max response time (ms):                           523
Min response time (ms):                             0
Avg response time (ms):                          8.95
```

## #5. V implementation.
```
Terminal 1: $ v .
            $ ./v.exe
Terminal 2: $ [baton]

apr_socket_recv: Transport endpoint is not connected (107)
```