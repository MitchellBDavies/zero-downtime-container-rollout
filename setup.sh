docker build --target server -t server:1.0.0 .
docker build --target server -t server:2.0.0 .
docker build --target load_balancer -t load_balancer .
docker build --target client -t client .