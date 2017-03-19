---
layout: default
---

## Server Configuration

### Ubuntu, make sure you have installed the following( Use sudo apt-get install openssh-server):



<p>openssh-server: SSH service</p>
<p>gunicorn: support gevent/p>
<p>Nginx: Web Server</p>
<p>python-gevent: 同步变异步协程</p>
<p>python-jinja2</p>
<p>python-mysql.connector</p>
<p>python-mysql.connector</p>
<p>Mysql Server and Client

```ruby
# Ruby code with syntax highlighting
sudo apt-get purge mysql-client-core-5.6
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get install mysql-client-core-5.5
sudo apt-get install mysql-server 
```
</p>

### Registration: 
1. Launch a new instance, choose viture machine, here I used ubuntu 14.04 AMI, got a xxx.pem file after registration, keep it in a safe place, this file is like a key for login, and you can not download it again if you lose it.

2. Under Network & Security --> Security Groups --> Inbound , remenber to open port 80 by adding a new rule. (Type: TCP, Port:80), cause my app use port 80 fot listening.

2. Both IP and DNS address will change after each restarts, so we should use elastic IP address. (TO DO)

3. Register RDS, put DB on RDS instead of server.(TO DO)

_<AWS>_

[back](./)
