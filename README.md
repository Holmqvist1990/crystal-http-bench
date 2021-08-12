# Crystal-HTTP-Bench.

Experimenting with Crystal, benching against a toy example I often use.

```
1. Deserialize JSON from wire.
        {"from": "steve", "url": "/steve", "text": "hello"}.

2. Insert into hash if text is new, no duplicates.
        [from][url].push(text)

3. Done.                                                 
```

Running with [ApacheBench](https://httpd.apache.org/docs/2.4/programs/ab.html).

```
ab -c 10 -n 15000 -p test.json -T application/x-www-form-urlencoded http://localhost:8080/ >result.txt 2>&1
```

## Go implementation.

```
Terminal 1: $ go run .
Terminal 2: [apache-bench]

Time per request:       2.803 [ms] (mean)
Time per request:       0.280 [ms] (mean, across all concurrent requests)
Transfer rate:          261.26 [Kbytes/sec] received
                        735.00 kb/s sent
                        996.25 kb/s total
```

## Crystal --release implementation.


```
Terminal 1: $ crystal build server.cr --release
            $ ./server
Terminal 2: [apache-bench]

Time per request:       3.023 [ms] (mean)
Time per request:       0.302 [ms] (mean, across all concurrent requests)
Transfer rate:          122.74 [Kbytes/sec] received
                        681.51 kb/s sent
                        804.25 kb/s total
```