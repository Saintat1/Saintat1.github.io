---
layout: post
title: Build Web App with Python
date: 2017-03-03 
tags: python  
---
### Preface
 Build up your own web app with Python + AWS

### AWS Configuration
**Recommended software:** 
>* WinSCP: Use this to move files between local and server.
>* PuTTY: Use .pem file to generate .pkk file, which is easier to login with.
>* Git Bash: Run scripts.

**Registration**

>* Launch a new instance, choose viture machine, here I used ubuntu 14.04 AMI. You will get a xxx.pem file after registration, keep it in a safe place, this file is the key for login, and you can not download it again if you lose it
>* Under Network & Security --> Security Groups --> Inbound , remenber to open port 80 by adding a new rule(Type: TCP, Port:80), cause my app use port 80 fot listening
>* Both IP and DNS address will change after each restarts, so we should use elastic IP address (TO DO)
>* Register RDS service, put database on RDS instead of server(TO DO)

### Sever Configuration
**If you are using Ubuntu, make sure you have installed the following( Use sudo apt-get install openssh-server):**
>* openssh-server: SSH service
>* gunicorn: support gevent， WSGI Server
>* Nginx: Web Server
>* python-gevent: convert code to asyn version
>* python-jinja2
>* python-mysql.connector
>* python-mysql.connector
>* Mysql Server and Client

It is a liitle bit tricky installing MySQL on Ubuntu, try to use the command below:

```bash
sudo apt-get purge mysql-client-core-5.6
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get install mysql-client-core-5.5
sudo apt-get install mysql-server 
```

>* supervisor: linux process management tool，it will restart the process if the process is aborted accidentally


### Nginx Configuration

Put this file under /etc/nginx/sites-available

```bash
server {
    listen      80;

    root       /srv/awesome/www;
    access_log /srv/awesome/log/access_log;
    error_log  /srv/awesome/log/error_log;

    server_name you.server.address;

    client_max_body_size 1m;

    gzip            on;
    gzip_min_length 1024;
    gzip_buffers    4 8k;
    gzip_types      text/css application/x-javascript application/json;

    sendfile on;

    location /favicon.ico {
        root /srv/awesome/www;
    }

    location ~ ^\/static\/.*$ {
        root /srv/awesome/www;
    }

    location / {
        proxy_pass       http://127.0.0.1:9000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

```

then run,

```bash
$ sudo ln -s /etc/nginx/sites-available/awesome .
$ sudo /etc/init.d/nginx reload

```
Logfile is under /var/log/supervisor

### Deploy

Local Test: use 

```bash
python wsgiapp.py
```
If port 9000 is occupied, use 

```bash
netstat -ano
netstat -aon|findstr "9000"
tasklist|findstr "4524"
taskkill /f  /t  /im QQ.exe
```

to release this port 9000.

Use

```bash
fab build
fab deploy
```

to rebuild and deploy, see details at https://segmentfault.com/a/1190000000497630