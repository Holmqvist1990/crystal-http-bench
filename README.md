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

Time taken for tests:   3.400 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    500000
Total transferred:      76000000 bytes
Total body sent:        410500000
HTML transferred:       3500000 bytes
Requests per second:    147059.52 [#/sec] (mean)
Time per request:       6.800 [ms] (mean)
Time per request:       0.007 [ms] (mean, across all concurrent requests)
Transfer rate:          21829.15 [Kbytes/sec] received
                        117906.12 kb/s sent
                        139735.26 kb/s total
```

## #2. Java implementation.

```
Terminal 1: $ ./mvnw exec:java
Terminal 2: $ [apachebench]

Time taken for tests:   6.350 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    500000
Total transferred:      45000000 bytes
Total body sent:        410500000
HTML transferred:       0 bytes
Requests per second:    78735.79 [#/sec] (mean)
Time per request:       12.701 [ms] (mean)
Time per request:       0.013 [ms] (mean, across all concurrent requests)
Transfer rate:          6920.14 [Kbytes/sec] received
                        63127.04 kb/s sent
                        70047.18 kb/s total
```

## #3. OCaml implementation.

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

## #4. Crystal implementation.

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

## #5. F# implementation.

```
Terminal 1: $ dotnet build --configuration Release
            $ ./bin/Release/net5.0/fsharp.exe
Terminal 2: $ [apachebench]

Time taken for tests:   32.936 seconds
Complete requests:      500000
Failed requests:        0
Keep-Alive requests:    500000
Total transferred:      79000000 bytes
Total body sent:        410500000
HTML transferred:       0 bytes
Requests per second:    15180.81 [#/sec] (mean)
Time per request:       65.873 [ms] (mean)
Time per request:       0.066 [ms] (mean, across all concurrent requests)
Transfer rate:          2342.35 [Kbytes/sec] received
                        12171.34 kb/s sent
                        14513.69 kb/s total
```

## #6. Janet implementation.

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

## #7. V implementation.
```
Terminal 1: $ v .
            $ ./v.exe
Terminal 2: $ [apachebench]

apr_socket_recv: Transport endpoint is not connected (107)
```
