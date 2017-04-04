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
> 1.Launch a new instance, choose viture machine, here I used ubuntu 14.04 AMI. You will get a xxx.pem file after registration, keep it in a safe place, this file is the key for login, and you can not download it again if you lose it.
> 2.Under Network & Security --> Security Groups --> Inbound , remenber to open port 80 by adding a new rule. (Type: TCP, Port:80), cause my app use port 80 fot listening.
> 3.Both IP and DNS address will change after each restarts, so we should use elastic IP address. (TO DO)
> 4.Register RDS service, put database on RDS instead of server.(TO DO)


### Sever Configuration
***If you are using Ubuntu, make sure you have installed the following( Use sudo apt-get install openssh-server):***
>*openssh-server: SSH service
>*gunicorn: support gevent， WSGI Server
>*Nginx: Web Server
>*python-gevent: convert code to asyn version
>*python-jinja2
>*python-mysql.connector
>*python-mysql.connector
>*Mysql Server and Client


```bash
sudo apt-get purge mysql-client-core-5.6
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get install mysql-client-core-5.5
sudo apt-get install mysql-server 
```
