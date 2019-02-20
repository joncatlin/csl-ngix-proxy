FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY empty_error_log /etc/nginx/logs/error.log