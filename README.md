## Introduction

The goal of this project is to provide an enviroment where you can develop your symfony3 projects under php7.1 with mysql 5.7.

## Usage

#### The basics

Inside the container the docroot is `/home/developer/project`. There are two ports listening: the 8080 is for dev mode and the 8081 is for prod.

Start the container:
```bash
$ docker run \
  -d \
  -p 127.0.32.2:3280:8080 \
  -p 127.0.32.2:3281:8081 \
  -p 127.0.32.3:3206:3306 \
  -v /the/docroot/of/your/project:/home/developer/project \
  --name my_s4_project \
  pelso/symfony3-php7.1-mysql5.7
```

For some cases (eg. clearing the cache) you should run a symfony command. You can use the php installed inside the container with the following mode:
```bash
$ docker exec -it -udeveloper my_s4_project /bin/bash
$ cd /home/developer/project/
```

If you prefer to use docker-compose, here's an [example](https://github.com/blalhu/docker-symfony-4.0-test-code/blob/master/docker/docker-compose.yml).

#### Configuring the services

There's loads of parameters both in nginx and php, what you probably want to set or override. You can use a small trick here. When you mount a volume, you can also set a file to share. So at first you save the original configuration file from the container to your host machine, then extend/override it.  After this you just simply share this file with a -v option, or under the volume section in your docker-compose.yml file.

Share with run:
```bash
$ docker run -v /path/to/my_nginx.conf:/etc/nginx/nginx.conf
```

Share with [docker-compose.yml](https://github.com/blalhu/docker-symfony-4.0-test-code/blob/master/docker/docker-compose.yml#L12).

#### Xdebug

This project comes with [Xdebug](https://xdebug.org/index.php). By default it tries to connect to the host on port 9000. The idekey is "XDEBUG_ECLIPSE". The remote mode is req, so you need to send "XDEBUG_SESSION=XDEBUG_ECLIPSE" cookie to the server (recommended to use a [browser plugin](https://confluence.jetbrains.com/display/PhpStorm/Browser+Debugging+Extensions)).

For console commands you can use something like this:
```bash
$ php -dxdebug.remote_autostart=On -dxdebug.remote_host=172.16.32.1 bin/console test
```
The ip is the address of your docker network's gateway.

Of course you can override these settings. Share your .ini to `/etc/php/7.1/mods-available/xdebug.ini`, just as you seen above. 

## Testing

This project was tested on an [example symfony4 code](https://github.com/blalhu/docker-symfony-4.0-test-code) which based on [symfony-skeleton](https://packagist.org/packages/symfony/skeleton) package.

## License

This project is licensed under the MIT License - see the [LICENSE.MIT](LICENSE.MIT) file for details