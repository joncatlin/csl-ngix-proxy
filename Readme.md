# Introduction
This is a simple reverse proxy to distribute incoming requests for a service to a docker swarm running the requested service.

# How To Build
```
$ docker build -t joncatlin/nginx .
```

# How To Run
```
$ docker run -d --name nginx -p 8000:80 joncatlin/nginx
```

# Configuration
The configuration is stored in nginx.conf file. All configuration changes need to update this file and rebuild and then redeploy the container.



