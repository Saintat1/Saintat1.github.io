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
>1.Launch a new instance, choose viture machine, here I used ubuntu 14.04 AMI, got a xxx.pem file after registration, keep it in a safe place, this file is like a key for login, and you can not download it again if you lose it.

>2.Under Network & Security --> Security Groups --> Inbound , remenber to open port 80 by adding a new rule. (Type: TCP, Port:80), cause my app use port 80 fot listening.

>2.Both IP and DNS address will change after each restarts, so we should use elastic IP address. (TO DO)

>3.Register RDS, put DB on RDS instead of server.(TO DO)
