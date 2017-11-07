FROM webdevops/php-nginx:ubuntu-16.04

LABEL Author="Alex Yeung <ayeung@aipm.co>"

# install all required packages
RUN apt-get update \
    && apt-get install wget unzip php7.0-mbstring php7.0-gd php7.0-intl php7.0-xml php7.0-mysql php7.0-mcrypt php7.0-zip curl php7.0-curl libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install ioncube
RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -O /tmp/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -C /tmp -xzf /tmp/ioncube_loaders_lin_x86-64.tar.gz \
    && cp /tmp/ioncube/ioncube_loader_lin_7.0.so /usr/lib/php/20151012/ \
    && rm -rf /tmp/ioncube /tmp/ioncube_loaders_lin_x86-64.tar.gz \
    && echo "zend_extension = \"/usr/lib/php/20151012/ioncube_loader_lin_7.0.so\"" > /etc/php/7.0/mods-available/ioncube.ini \
    && ln -s /etc/php/7.0/mods-available/ioncube.ini 00-ioncube.ini

# download whmcs
RUN wget http://hkalex.com/whmcs/whmcs_v730_full_nulled_by_jonvi.zip -O /tmp/whmcs_v730_full_nulled_by_jonvi.zip \
    && unzip /tmp/whmcs_v730_full_nulled_by_jonvi.zip -d /var/www/whmcs/ \
    && rm -rf /tmp/whmcs_v730_full_nulled_by_jonvi.zip \
    && cp /var/www/whmcs/configuration.php.new /var/www/whmcs/configuration.php \
    && chmod 766 /var/www/whmcs/configuration.php

# download nginx configuration
# COPY conf/nginx-default /etc/nginx/sites-available/default

EXPOSE 443 80

CMD ["/start.sh"]
