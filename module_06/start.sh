echo "without cache"
wrk -d 60 -t 1 -c 1 --latency -s ./get.lua http://localhost:8081/

echo "with cache"
wrk -d 60 -t 1 -c 1 --latency -s ./get.lua http://localhost:8082/