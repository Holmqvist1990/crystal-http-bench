# HTTP-JSON-Bench.

Benching a tiny in-memory **C**RUD HTTP server implementation in a various languages.

```
HTTP POST -> JSON Body -> {Person} > Add into mutable List<Person>
```

Benching with [ApacheBench](https://httpd.apache.org/docs/2.4/programs/ab.html).

```
ab -c 1000 -n 500000 -p test.json -T application/x-www-form-urlencoded -k http://localhost:3000/ >result.txt 2>&1

1000 connections.
500 000 requests.
Keep alive.
```

## #1. Go implementation.

```
Terminal 1: $ go run .
Terminal 2: [apachebench]

Time taken for tests:   3.181 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    500000
Total transferred:      52000000 bytes
Total body sent:        410500000
HTML transferred:       0 bytes
Requests per second:    157184.46 [#/sec] (mean)
Time per request:       6.362 [ms] (mean)
Time per request:       0.006 [ms] (mean, across all concurrent requests)
Transfer rate:          15964.05 [Kbytes/sec] received
                        126023.87 kb/s sent
                        141987.92 kb/s total
```

## #2. Crystal implementation.

```
Terminal 1: $ crystal build server.cr --release
            $ ./server
Terminal 2: [apachebench]

Time taken for tests:   19.589 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    500000
Total transferred:      31000000 bytes
Total body sent:        423000000
HTML transferred:       0 bytes
Requests per second:    25524.37 [#/sec] (mean)
Time per request:       39.178 [ms] (mean)
Time per request:       0.039 [ms] (mean, across all concurrent requests)
Transfer rate:          1545.42 [Kbytes/sec] received
                        21087.52 kb/s sent
                        22632.94 kb/s total
```

## #3. F# implementation.

```
Terminal 1: $ dotnet build --configuration Release
            $ ./bin/Release/net5.0/fsharp.exe
Terminal 2: $ [apachebench]

Time taken for tests:   34.259 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    500000
Total transferred:      79000000 bytes
Total body sent:        423000000
HTML transferred:       0 bytes
Requests per second:    14594.63 [#/sec] (mean)
Time per request:       68.518 [ms] (mean)
Time per request:       0.069 [ms] (mean, across all concurrent requests)
Transfer rate:          2251.91 [Kbytes/sec] received
                        12057.68 kb/s sent
                        14309.58 kb/s total
```

## #4. OCaml implementation.

```
Terminal 1: $ dune build
            $ dune exec ./ocamlbench.exe
Terminal 2: $ [apachebench]

Time taken for tests:   49.154 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    250038
Total transferred:      15512896 bytes
Total body sent:        423000000
HTML transferred:       0 bytes
Requests per second:    10172.13 [#/sec] (mean)
Time per request:       98.308 [ms] (mean)
Time per request:       0.098 [ms] (mean, across all concurrent requests)
Transfer rate:          308.20 [Kbytes/sec] received
                        8403.93 kb/s sent
                        8712.13 kb/s total
```

## #5. Janet implementation.

```
Terminal 1: $ jpm build
            $ ./build/app
Terminal 2: $ [apachebench]

Time taken for tests:   407.365 seconds
Complete requests:      58000
Failed requests:        0
Keep-Alive requests:    0
Total transferred:      11446000 bytes
Total body sent:        48439000
HTML transferred:       0 bytes
Requests per second:    142.38 [#/sec] (mean)
Time per request:       7023.535 [ms] (mean)
Time per request:       7.024 [ms] (mean, across all concurrent requests)
Transfer rate:          27.44 [Kbytes/sec] received
                        116.12 kb/s sent
                        143.56 kb/s total
```

## #6. V implementation.
```
Terminal 1: $ v .
            $ ./v.exe
Terminal 2: $ [apachebench]

apr_socket_recv: Transport endpoint is not connected (107)
```