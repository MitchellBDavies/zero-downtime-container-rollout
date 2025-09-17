docker network create load_balanced_net

docker run --rm -d --net load_balanced_net --name consul_server -p 8500:8500 -p 8600:8600/udp hashicorp/consul:1.21.4 agent -server -bootstrap-expect=1 -node=server-1 -ui -client=0.0.0.0 

sh ./util_scripts/server_container_startup.sh server_1 1.0.0 8001
sh ./util_scripts/server_container_startup.sh server_2 1.0.0 8002
sh ./util_scripts/server_container_startup.sh server_3 1.0.0 8003
sh ./util_scripts/server_container_startup.sh server_4 1.0.0 8004

mkdir -p consulregistermount
docker run --rm -d --net load_balanced_net --name consul_registration_agent --mount type=bind,source="$(pwd)"/consulregistermount,target="/consul/config" hashicorp/consul:latest agent -join=consul_server

mkdir -p nginxmount
cp loadbalancer/nginx.conf.ctmpl nginxmount/
docker run --rm -d --net load_balanced_net --name load_balancer -p 80:80 --mount type=bind,source="$(pwd)"/nginxmount,target=/etc/consul-template/ load_balancer
docker exec -d load_balancer consul-template -consul-addr=consul_server:8500 -template="//etc/consul-template/nginx.conf.ctmpl://etc/nginx/conf.d/default.conf:nginx -s reload"