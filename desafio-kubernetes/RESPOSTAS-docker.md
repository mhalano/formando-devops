1.
```bash
➜ docker run --rm -it alpine hostname
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
213ec9aee27d: Pull complete 
Digest: sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad
Status: Downloaded newer image for alpine:latest
28c454606912
```

2.
```bash
➜ docker run -d -p 8080:80 nginx:1.22 
afca340da9a2cb3c9598aca4c404eb978fb8bd87d1e2b186e51c2c951584bd1d
➜ docker container ls                          
CONTAINER ID   IMAGE                  COMMAND                  CREATED          STATUS          PORTS                                   NAMES
afca340da9a2   nginx:1.22             "/docker-entrypoint.…"   31 seconds ago   Up 31 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   amazing_cray
```

3.
```bash
docker cp cf9a7f3cf62344f2be6dcba33058cd0b133dfbc6e53e98065a9f5f86d1c5f8fc:/etc/nginx/conf.d/default.conf .
vim default.conf (muda a porta de 80 para 90)
➜ docker run -d -p 8080:90 --mount type=bind,src=$PWD/default.conf,dst=/etc/nginx/conf.d/default.conf,readonly nginx:1.22
8b024a5c884e5acef409ee7f3de2edd0153933a65ac7a8e145191ff541da0c75
➜ curl localhost:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
```

4.
```bash
➜ cat Dockerfile
FROM python
ADD hello-world.py /
ENTRYPOINT python /hello-world.py
➜ docker build -t teste .
Sending build context to Docker daemon  3.072kB
Step 1/3 : FROM python
 ---> f05c8762fe15
Step 2/3 : ADD hello-world.py /
 ---> a4cdce42717b
Step 3/3 : ENTRYPOINT python /hello-world.py
 ---> Running in c6061dcf59bc
Removing intermediate container c6061dcf59bc
 ---> 6214b8806642
Successfully built 6214b8806642
Successfully tagged teste:latest

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
➜ docker run teste       
Hello World in Python!
```

5. `docker run --cpus 0.5 -d --memory 128M nginx`

6. `docker system prune`

7. Essa informação aparece no Docker Hub: https://hub.docker.com/layers/library/ubuntu/latest/images/sha256-a8fe6fd30333dc60fc5306982a7c51385c2091af1e0ee887166b40a905691fd0?context=explore

8.
