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

Or [wrk](https://github.com/wg/wrk) in the case of Janet (as `ab` doesn't seem to jive here):

```
wrk -t6 -d10 -c1000 -s wrk.lua http://localhost:3000/
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

## 2. OCaml implementation.

```
Terminal 1: $ dune build
            $ dune exec ./ocamlbench.exe
Terminal 2: $ [apachebench]

Time taken for tests:   9.217 seconds
Complete requests:      500000
Failed requests:        242317
   (Connect: 0, Receive: 0, Length: 0, Exceptions: 242317)
Keep-Alive requests:    250000
Total transferred:      15500000 bytes
Total body sent:        410500000
HTML transferred:       0 bytes
Requests per second:    54246.94 [#/sec] (mean)
Time per request:       18.434 [ms] (mean)
Time per request:       0.018 [ms] (mean, across all concurrent requests)
Transfer rate:          1642.24 [Kbytes/sec] received
                        43492.91 kb/s sent
                        45135.15 kb/s total
```

## #3. Crystal implementation.

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

## #4. F# implementation.

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

## #5. Janet implementation.

```
Terminal 1: $ jpm build
            $ ./build/app
Terminal 2: $ [wrk]

Running 10s test @ http://localhost:3000/
  6 threads and 1000 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   109.21ms   66.23ms   1.99s    92.59%
    Req/Sec     0.93k   615.53     4.32k    69.61%
  55395 requests in 10.10s, 10.25MB read
  Socket errors: connect 0, read 0, write 0, timeout 133
Requests/sec:   5486.00
Transfer/sec:      1.01MB
```

## #6. V implementation.
```
Terminal 1: $ v .
            $ ./v.exe
Terminal 2: $ [apachebench]

apr_socket_recv: Transport endpoint is not connected (107)
```
