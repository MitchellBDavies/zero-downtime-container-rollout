# Zero Downtime Container Rollout #
Just a small project to test out a custom zero downtime system using nginx, & podman. Note that this doesn't work with Docker, but could probably be easily modifed to work with Docker. 

# Instructions to run locally #
If you have a desire to run this project, do so at your own risk. It was designed to run on my personal PC, and no one elses. 

Build the images using the setup script. This will create 4 images, 1 for nginx, 1 for a client, and 2 servers that represent an old version and target deployment.

`./setup.sh`

Run the start script to spin up 4 servers that send simple responses to a client behind the nginx server.

`./start_servers.sh`

To start making requests (And watch them as they happen), run the client in a seperate shell.

`podman run --rm --net load_balanced_net --name client client`

To start a new deployment, you can start by running the canary script. The intention of this script is to add a 5th server that is running the newest version, so that it can be monitored in production on a small portion of traffic. The script will spin up the 5th server and then modify the nginx server to recognize this new server.

`./canary.sh`

While there are both servers running, you'll be able to see the client hitting both versions of code:
```
{'status_code': 200, 'body': '{"message":"Hello World","version":"1.0.0"}'}
{'status_code': 200, 'body': '{"message":"Hello World","version":"2.0.0"}'}
```

To clean up the pods that are running, you can run the cleanup script. This will kill the named pods in this project and delete it's network. Be careful if you have pods or networks that are named similarily, as they may get deleted.

`./cleanup.sh`

# Future Development #
- Not quite Zero Downtime yet (Small period when the nginx server is restarting).
- A 50/50 deployment (Or at least more staging beyond the canary deployment).
- A full rollout deployment (Likely a pipeline that will phase out the remaining old servers for new ones).
- A rollback system in case the new server is producing higher than expected bugs.
    - Possibly automated watching for server responses, but that's likely beyond the skope of this project.
- More sofisticated deployment scripts. Currently deployments and configs are hardcoded, but a more dynamic system would be desired.