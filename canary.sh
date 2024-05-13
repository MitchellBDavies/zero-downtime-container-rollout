podman run --rm -d --net load_balanced_net --name canary -p 8005:8000 -e VERSION=2.0.0 server:2.0.0

cp loadbalancer/canary.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload