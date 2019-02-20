# How To Build

# How To Run
```
$ docker run --name ngix -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx
```

# Configuration
The configuration is stored in nginx.conf. All configuration changes need to update this file and rebuild and then redeploy the container.









# Complex configuration
$ docker run --name my-custom-nginx-container -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d nginx
For information on the syntax of the nginx configuration files, see the official documentation (specifically the Beginner's Guide).

If you wish to adapt the default configuration, use something like the following to copy it from a running nginx container:

$ docker run --name tmp-nginx-container -d nginx
$ docker cp tmp-nginx-container:/etc/nginx/nginx.conf /host/path/nginx.conf
$ docker rm -f tmp-nginx-container
This can also be accomplished more cleanly using a simple Dockerfile (in /host/path/):

FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
If you add a custom CMD in the Dockerfile, be sure to include -g daemon off; in the CMD in order for nginx to stay in the foreground, so that Docker can track the process properly (otherwise your container will stop immediately after starting)!

Then build the image with docker build -t custom-nginx . and run it as follows:

$ docker run --name my-custom-nginx-container -d custom-nginx
Using environment variables in nginx configuration
Out-of-the-box, nginx doesn't support environment variables inside most configuration blocks. But envsubst may be used as a workaround if you need to generate your nginx configuration dynamically before nginx starts.

Here is an example using docker-compose.yml:

web:
  image: nginx
  volumes:
   - ./mysite.template:/etc/nginx/conf.d/mysite.template
  ports:
   - "8080:80"
  environment:
   - NGINX_HOST=foobar.com
   - NGINX_PORT=80
  command: /bin/bash -c "envsubst < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
The mysite.template file may then contain variable references like this:

listen ${NGINX_PORT};

Running nginx in read-only mode