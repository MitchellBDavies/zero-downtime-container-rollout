podman build --target server -t server:1.0.0 .
podman build --target server -t server:2.0.0 .
podman build --target load_balancer -t load_balancer .
podman build --target client -t client .