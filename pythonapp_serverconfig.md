---
layout: default
---

[back](./)

## Server Configuration

### Ubuntu, make sure you have installed the following( Use sudo apt-get install openssh-server):



<p>openssh-server: SSH service</p>
<p>gunicorn: support gevent， WSGI Server</p>
<p>Nginx: Web Server</p>
<p>python-gevent: 同步代码变异步协程()</p>
<p>python-jinja2</p>
<p>python-mysql.connector</p>
<p>python-mysql.connector</p>
<p>Mysql Server and Client</p>


```bash
# Ruby code with syntax highlighting
sudo apt-get purge mysql-client-core-5.6
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get install mysql-client-core-5.5
sudo apt-get install mysql-server 
```

<p>supervisor: linux管理进程的工具，随系统的启动而启动服务，监控服务进程，如果进程意外推出会自动重启服务</p>


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

Use

```python
fab build
fab deploy
```

to rebuild and deploy



[back](./)
