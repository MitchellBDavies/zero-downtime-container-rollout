podman run --rm -d --net load_balanced_net --name canary -p 8005:8000 -e VERSION=2.0.0 -e SERVER=canary  server:2.0.0

until podman healthcheck run canary
do 
    sleep 1
done

cp loadbalancer/canary.conf nginxmount/nginx.conf
podman exec load_balancer nginx -s reload