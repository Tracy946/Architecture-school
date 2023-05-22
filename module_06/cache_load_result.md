# 1 thread and 1 connection
**Without cache:**   
| Thread Stats |  Avg   |   Stdev  |   Max |  +/- Stdev |
|---------|---------|---------|---------|---------|
    Latency    35.78ms  186.47ms   1.83s    96.42%
    Req/Sec   321.14     53.04   414.00     78.39%
| Latency | Distribution |
| --------- | -----------|
| 50%  |  3.01ms |
| 75%  |  3.32ms  |
| 90%  |  3.86ms  |
| 99%  |  1.20s  |

  16338 requests in 1.00m, 4.50MB read

  Socket errors: connect 0, read 0, write 0, timeout 2

Requests/sec: 272.08. Transfer/sec: 76.79KB.

**Without cache:**
| Thread Stats |  Avg   |   Stdev  |   Max |  +/- Stdev |
|---------|---------|---------|---------|---------|
    Latency     3.57ms   22.89ms 466.66ms   99.29%
    Req/Sec   563.65    107.02   770.00     76.88%
 
| Latency | Distribution |
| --------- | -----------|
|     50%  |  1.63ms |
|     75%  |  1.84ms |
|     90%  |  2.25ms |
|     99%  | 16.41ms |

  32851 requests in 1.03m, 9.27MB read

  Socket errors: connect 0, read 0, write 0, timeout 1

Requests/sec: 529.98. Transfer/sec: 153.20KB.

# 10 threads and 10 connections
**Without cache:**  
| Thread Stats |  Avg   |   Stdev  |   Max |  +/- Stdev |
|---------|---------|---------|---------|---------|
    Latency    77.55ms  171.82ms   1.98s    95.94%
    Req/Sec    21.43      7.50    40.00     47.69%
  
| Latency | Distribution |
| --------- | -----------|
|     50%  | 41.43ms |
|     75%  | 51.59ms |
|     90%  | 80.63ms |
|     99%  |  1.14s |

  9097 requests in 1.15m, 2.57MB read

  Socket errors: connect 0, read 0, write 0, timeout 36

Requests/sec: 131.99. Transfer/sec: 38.14KB.

**With cache:**
| Thread Stats |  Avg   |   Stdev  |   Max |  +/- Stdev |
|---------|---------|---------|---------|---------|
    Latency    42.16ms   22.36ms 329.71ms   83.04%
    Req/Sec    24.63      9.20    70.00     74.92%

| Latency | Distribution |
| --------- | -----------|
|     50% |  37.70ms |
|     75% |  49.24ms |
|     90% |  66.57ms |
|     99% | 116.15ms |

  14683 requests in 1.00m, 4.12MB read

Requests/sec:    244.42. Transfer/sec:     70.15KB.

# 50 threads and 50 connections
**Without cache:**  
| Thread Stats |  Avg   |   Stdev  |   Max |  +/- Stdev |
|---------|---------|---------|---------|---------|
    Latency   453.67ms  181.68ms 641.30ms   61.54%
    Req/Sec     1.96      1.18     5.00     92.31%

| Latency | Distribution |
| --------- | -----------|
|     50% | 573.08ms |
|     75% | 589.74ms |
|     90% | 637.63ms |
|     99% | 641.30ms |

  26 requests in 1.00m, 7.54KB read
  
Requests/sec:      0.43. Transfer/sec:     128.51B.

**With cache:**
| Thread Stats |  Avg   |   Stdev  |   Max |  +/- Stdev |
|---------|---------|---------|---------|---------|
    Latency   367.64ms  115.66ms 436.69ms   83.33%
    Req/Sec     1.09      1.30     4.00     90.91%

| Latency | Distribution |
| --------- | -----------|
|     50% | 431.33ms|
|     75% | 433.12ms|
|     90% | 436.69ms|
|     99% | 436.69ms|

  11 requests in 1.00m, 3.20KB read

  Socket errors: connect 0, read 5, write 0, timeout 5

Requests/sec:      0.18. Transfer/sec:      54.51B