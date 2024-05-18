podman build --target server -t server:1.0.0 --format docker .
podman build --target server -t server:2.0.0 --format docker .
podman build --target load_balancer -t load_balancer --format docker .
podman build --target client -t client --format docker .