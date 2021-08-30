# HTTP-JSON-Bench.

Benching a tiny in-memory C**R**UD HTTP server implementation in a various languages.

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

Time taken for tests:   8.209 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    500000
Total transferred:      52000000 bytes
Total body sent:        423000000
HTML transferred:       0 bytes
Requests per second:    60906.14 [#/sec] (mean)
Time per request:       16.419 [ms] (mean)
Time per request:       0.016 [ms] (mean, across all concurrent requests)
Transfer rate:          6185.78 [Kbytes/sec] received
                        50318.94 kb/s sent
                        56504.72 kb/s total
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

Time taken for tests:   155.245 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    0
Total transferred:      18999392 bytes
Total body sent:        423000000
HTML transferred:       0 bytes
Requests per second:    3220.71 [#/sec] (mean)
Time per request:       310.491 [ms] (mean)
Time per request:       0.310 [ms] (mean, across all concurrent requests)
Transfer rate:          119.51 [Kbytes/sec] received
                        2660.86 kb/s sent
                        2780.37 kb/s total
```

## #5. V implementation.
```
Terminal 1: $ v .
            $ ./v.exe
Terminal 2: $ [apachebench]

apr_socket_recv: Transport endpoint is not connected (107)
```