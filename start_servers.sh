podman network create load_balanced_net

podman run --rm -d --net load_balanced_net --name server_1 -p 8001:8000 -e VERSION=1.0.0 -e SERVER=server_1 server:1.0.0
podman run --rm -d --net load_balanced_net --name server_2 -p 8002:8000 -e VERSION=1.0.0 -e SERVER=server_2  server:1.0.0
podman run --rm -d --net load_balanced_net --name server_3 -p 8003:8000 -e VERSION=1.0.0 -e SERVER=server_3  server:1.0.0
podman run --rm -d --net load_balanced_net --name server_4 -p 8004:8000 -e VERSION=1.0.0 -e SERVER=server_4  server:1.0.0

cp loadbalancer/nginx.conf nginxmount/nginx.conf
podman run --rm --net load_balanced_net --name load_balancer -d -p 80:80 --mount type=bind,source="$(pwd)"/nginxmount,target=/etc/nginx/conf.d/ load_balancer