# Start with the Alpine base image
FROM alpine:3.19

# Install Nginx and OpenSSL
RUN apk update && apk add nginx openssl

# Generate self-signed SSL certificates
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/CN=localhost"

# Copy custom Nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose the default HTTPS port
EXPOSE 443

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
