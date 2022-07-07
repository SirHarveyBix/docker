FROM composer:latest

#     in case of error : 
# RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel
# USER laravel

WORKDIR /var/www/html

ENTRYPOINT ["composer", "--ignore-platform-reqs"]
# Running composer without warn / errors