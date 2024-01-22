My personal Dockerfile (no extra scripts) that will download and run a PalWorld dedicated server.

Currently works, using the official instructions from the PalWorld developers to get past a steam.so error.

Game folder is a volume on `/game/`.
Default game port is 8211, but it can be changed by editing the GAMEPORT environment variable when creating the container (shown in the `run` command below. Note that the game port is UDP, in case firewall rules need to be edited.

I build it with:
```
sudo podman build --tag palserver .
```

and I run it with:
```
sudo podman run -d --name palserver -e GAMEPORT=8211 -p 8211:8211/udp -v ~/palserver/:/game/:Z localhost/palserver:latest
```
