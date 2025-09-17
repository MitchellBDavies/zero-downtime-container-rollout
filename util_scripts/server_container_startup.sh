name=$1
version=$2
port_num=$3

docker run --rm -d --net load_balanced_net --name $name -p $port_num:8000 -e VERSION=$version -e SERVER=$name server:$version

conf=$(cat <<-END
    {
        "service": {
            "id": "$name",
            "name": "server",
            "tags": ["production"],
            "port": 8000,
            "address": "$name",
            "check": {
                "id": "${name}_health",
                "name": "Health check for $name",
                "http": "http://$name:8000/health",
                "method": "GET",
                "interval": "10s",
                "timeout": "1s"
            }
        }
    }

END
)
echo $conf > consulregistermount/${name}_config.json