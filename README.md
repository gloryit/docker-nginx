### About Docker
- Written in: Docker (Version: v17.12)

------

### :fire::fire: IMPORTANT IF YOU ARE DEVELOPER !!!

##### Installation:
- docker: https://docs.docker.com/install/
- docker-compose: https://docs.docker.com/compose/install/

##### Config files:
- Copy file ssl to amazonlinux/ssl/
- Copy file config VirtualHost to amazonlinux/conf.d/
- Copy file .env.default to .env and config PATH_APP=path/to/project

------

### Run build amazonlinux (only one time)
```
docker-compose build
```
### Run start server amazonlinux:
```bash
docker-compose up -d
```
### Run stop server amazonlinux
```bash
docker-compose down
```

------
