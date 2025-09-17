name=$1

rm consulregistermount/"$name"_config.json
docker exec -d consul_registration_agent consul reload

docker kill $name