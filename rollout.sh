cp loadbalancer/server_1_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_1
podman run --rm -d --net load_balanced_net --name server_1 -p 8001:8000 -e VERSION=2.0.0 -e SERVER=server_1 server:2.0.0

until podman healthcheck run server_1
do 
    sleep 1
done

cp loadbalancer/server_2_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_2
podman run --rm -d --net load_balanced_net --name server_2 -p 8002:8000 -e VERSION=2.0.0 -e SERVER=server_2 server:2.0.0

until podman healthcheck run server_2
do 
    sleep 1
done

cp loadbalancer/server_3_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_3
podman run --rm -d --net load_balanced_net --name server_3 -p 8003:8000 -e VERSION=2.0.0 -e SERVER=server_3 server:2.0.0

until podman healthcheck run server_3
do 
    sleep 1
done

cp loadbalancer/server_4_replace.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill server_4
podman run --rm -d --net load_balanced_net --name server_4 -p 8004:8000 -e VERSION=2.0.0 -e SERVER=server_4 server:2.0.0

until podman healthcheck run server_4
do 
    sleep 1
done

cp loadbalancer/nginx.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload

podman kill canary