# HTTP-JSON-Bench.

Running with [ApacheBench](https://httpd.apache.org/docs/2.4/programs/ab.html).

```
ab -c 10 -n 50000 -p test.json -T application/x-www-form-urlencoded http://localhost:3000/ >result.txt 2>&1
```

## Go implementation.

```
Terminal 1: $ go run .
Terminal 2: [apache-bench]

Time taken for tests:   13.240 seconds
Complete requests:      50000
Failed requests:        0
Total transferred:      4000000 bytes
Total body sent:        41100000
HTML transferred:       0 bytes
Requests per second:    3776.44 [#/sec] (mean)
Time per request:       2.648 [ms] (mean)
Time per request:       0.265 [ms] (mean, across all concurrent requests)
Transfer rate:          295.03 [Kbytes/sec] received
                        3031.48 kb/s sent
                        3326.51 kb/s total
```

## Crystal implementation.

```
Terminal 1: $ crystal build server.cr --release
            $ ./server
Terminal 2: [apache-bench]

Time taken for tests:   16.421 seconds
Complete requests:      50000
Failed requests:        0
Total transferred:      1900000 bytes
Total body sent:        41100000
HTML transferred:       0 bytes
Requests per second:    3044.92 [#/sec] (mean)
Time per request:       3.284 [ms] (mean)
Time per request:       0.328 [ms] (mean, across all concurrent requests)
Transfer rate:          113.00 [Kbytes/sec] received
                        2444.26 kb/s sent
                        2557.26 kb/s total
```

## OCaml implementation.

```
Terminal 1: $ dune exec ./ocamlbench.exe
Terminal 2: $ [apache-bench]

Time taken for tests:   19.005 seconds
Complete requests:      50000
Failed requests:        0
Total transferred:      1900000 bytes
Total body sent:        41100000
HTML transferred:       0 bytes
Requests per second:    2630.93 [#/sec] (mean)
Time per request:       3.801 [ms] (mean)
Time per request:       0.380 [ms] (mean, across all concurrent requests)
Transfer rate:          97.63 [Kbytes/sec] received
                        2111.94 kb/s sent
                        2209.57 kb/s total
```

## F# implementation.

```
Terminal 1: $ dotnet build --configuration Release
            $ ./bin/Release/net5.0/fsharp.exe
Terminal 2: $ [apache-bench]

Time taken for tests:   19.746 seconds
Complete requests:      50000
Failed requests:        0
Total transferred:      6700000 bytes
Total body sent:        41100000
HTML transferred:       0 bytes
Requests per second:    2532.20 [#/sec] (mean)
Time per request:       3.949 [ms] (mean)
Time per request:       0.395 [ms] (mean, across all concurrent requests)
Transfer rate:          331.36 [Kbytes/sec] received
                        2032.69 kb/s sent
                        2364.05 kb/s total
```