# Crystal-HTTP-Bench.

Experimenting with Crystal, benching against a toy example I often use.

```
1. Deserialize JSON from wire.
        {"from": "steve", "url": "/steve", "text": "hello"}

2. Insert into hash if text is new, no duplicates.
        [from][url].push(text)

3. Done.                                                 
```

Running with [ApacheBench](https://httpd.apache.org/docs/2.4/programs/ab.html).

```
ab -c 10 -n 25000 -p test.json -T application/x-www-form-urlencoded http://localhost:8080/ >result.txt 2>&1
```

Currently only testing with one set of json, but `real use` would imply several different sets.

## Go implementation.

```
Terminal 1: $ go run .
Terminal 2: [apache-bench]

Time per request:       2.424 [ms] (mean)
Time per request:       0.242 [ms] (mean, across all concurrent requests)
Transfer rate:          302.12 [Kbytes/sec] received
                        825.79 kb/s sent
                        1127.90 kb/s total
```

## Crystal --release implementation.


```
Terminal 1: $ crystal build server.cr --release
            $ ./server
Terminal 2: [apache-bench]

Time per request:       3.193 [ms] (mean)
Time per request:       0.319 [ms] (mean, across all concurrent requests)
Transfer rate:          116.23 [Kbytes/sec] received
                        627.01 kb/s sent
                        743.24 kb/s total
```