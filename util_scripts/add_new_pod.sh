name=$1
version=$2
port_num=$3

sh .$pwd/util_scripts/server_container_startup.sh $name $version $port_num

health=$(docker inspect --format "{{json .State.Health.Status }}" $name)
until [[ "$health" == "\"healthy\"" ]]
do 
    sleep 1
    health=$(docker inspect --format "{{json .State.Health.Status }}" $name)
done

docker exec -d consul_registration_agent consul reload