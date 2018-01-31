### About Docker
- Written in: Docker (Version: v17.12)

------

### :fire::fire: IMPORTANT IF YOU ARE DEVELOPER !!!

##### Installation:
- docker: https://docs.docker.com/install/
- docker-compose: https://docs.docker.com/compose/install/
##### Config files:
- All project in /www (config in file docker-compose.yml line 13)
- Copy file ssl to amazonlinux/ssl/
- Copy file config VirtualHost to amazonlinux/conf.d/

------

### Run build amazonlinux (only one time)
```
docker-compose build
```
##### Run start server amazonlinux:
```bash
docker-compose up -d
```
##### Run stop server amazonlinux
```bash
docker-compose down
```

------
