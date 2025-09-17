sh ./util_scripts/remove_pod.sh server_1
sh ./util_scripts/add_new_pod.sh server_1 2.0.0 8001
sleep 5

sh ./util_scripts/remove_pod.sh server_2
sh ./util_scripts/add_new_pod.sh server_2 2.0.0 8002
sleep 5

sh ./util_scripts/remove_pod.sh server_3
sh ./util_scripts/add_new_pod.sh server_3 2.0.0 8003
sleep 5

sh ./util_scripts/remove_pod.sh server_4
sh ./util_scripts/add_new_pod.sh server_4 2.0.0 8004
sleep 5

sh ./util_scripts/remove_pod.sh canary