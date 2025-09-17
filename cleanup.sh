docker kill client
docker kill server_1
docker kill server_2
docker kill server_3
docker kill server_4
docker kill canary
docker kill load_balancer
docker kill consul_server
docker kill consul_registration_agent
docker network rm load_balanced_net

rm consulregistermount/*
rm nginxmount/*