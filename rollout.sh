cp loadbalancer/server_1_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_1
podman run --rm -d --net load_balanced_net --name server_1 -p 8001:8000 -e VERSION=2.0.0 server:2.0.0

cp loadbalancer/server_2_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_2
podman run --rm -d --net load_balanced_net --name server_2 -p 8002:8000 -e VERSION=2.0.0 server:2.0.0

cp loadbalancer/server_3_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_3
podman run --rm -d --net load_balanced_net --name server_3 -p 8003:8000 -e VERSION=2.0.0 server:2.0.0

cp loadbalancer/server_4_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_4
podman run --rm -d --net load_balanced_net --name server_4 -p 8004:8000 -e VERSION=2.0.0 server:2.0.0

cp loadbalancer/nginx.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill canary