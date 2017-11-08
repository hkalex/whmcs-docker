#/bin/bash

service php7.0-fpm restart && nginx -g 'daemon off;'
