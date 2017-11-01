## Introduction

The goal of this project is to provide an enviroment where you can develop your symfony4 projects under php7.1.

## Usage

#### The basics

Inside the container the docroot is `/home/developer/project`. There are two ports listening: the 8080 is for dev
mode and the 8081 is for prod.

Start the container:
```bash
$ docker run \
  -d \
  -p 127.0.32.2:3280:8080 \
  -p 127.0.32.2:3281:8081 \
  -v /the/docroot/of/your/project:/home/developer/project \
  --name my_s4_project \
  pelso/symfony4.0-php7.1:unstable
```

For some cases (eg. clearing the cache) you should run a symfony command. You can use the php installed inside the
container with the following mode:
```bash
$ docker exec -it -udeveloper my_s4_project /bin/bash
$ cd /home/developer/project/
```

If you prefer to use docker-compose, here's an
[example](https://github.com/blalhu/docker-symfony-4.0-test-code/blob/master/docker/docker-compose.yml).

#### Configuring the services

There's loads of parameters both in nginx and php, what you probably want to set or override. You can use a small trick
here. When you mount a volume, you can also set a file to share. So at first you save the original configuration file
from the container to your host machine, then extend/override it.  After this you just simply share this file with a -v
option, or under the volume section in your docker-compose.yml file.

Share with run:
```bash
$ docker run -v /path/to/my_nginx.conf:/etc/nginx/nginx.conf
```

Share with
[docker-compose.yml](https://github.com/blalhu/docker-symfony-4.0-test-code/blob/master/docker/docker-compose.yml#L12).

## Testing

This project was tested on an [example symfony4 code](https://github.com/blalhu/docker-symfony-4.0-test-code) which
based on [symfony-skeleton](https://packagist.org/packages/symfony/skeleton#v4.0.0-BETA1) package.

## License

This project is licensed under the MIT License - see the [LICENSE.MIT](LICENSE.MIT) file for details