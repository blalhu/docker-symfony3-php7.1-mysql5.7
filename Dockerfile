FROM ubuntu:17.10

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    php7.1 \
    php7.1-fpm \
    php7.1-mysql \
    php7.1-sqlite \
    php7.1-pgsql \
    php7.1-xml \
    php7.1-mbstring \
    php7.1-curl \
    php7.1-zip \
    php7.1-imagick \
    php7.1-gd \
    nginx

RUN apt-get update && apt-get install -y sudo \
    htop \
    vim \
    iputils-ping \
    net-tools \
    mysql-client \
    sqlite3 \
    postgresql-client \
    git \
    mc

RUN useradd -mUG sudo developer && \
    echo 'developer:developer' | chpasswd && \
    chsh -s /bin/bash developer

RUN sed -i -- 's/www-data/developer/g' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i -- 's/www-data/developer/g' /etc/nginx/nginx.conf

COPY nginx/* /etc/nginx/sites-enabled/
COPY entrypoint.sh /home/developer/

CMD /home/developer/entrypoint.sh ; sleep infinity