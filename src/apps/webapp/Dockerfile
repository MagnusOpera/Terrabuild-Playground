ARG nginx_version="latest"
FROM nginx:${nginx_version}

# Create app directory
WORKDIR /usr/src/app

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

COPY default.conf /etc/nginx/conf.d/default.conf

## From 'builder' copy website to default nginx public folder
COPY ./dist/ /usr/share/nginx/html
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
EXPOSE 80
