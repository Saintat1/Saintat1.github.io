---
layout: default
---

## AWS Configuration

### Recommended software: 
<p>WinSCP: Use this to move files between local and server.</p>
<p>PuTTY: Use .pem file to generate .pkk file, which is easier to login with.</p>
<p>Git Bash: Run scripts.</p>


### Registration: 
1. Launch a new instance, choose viture machine, here I used ubuntu 14.04 AMI, got a xxx.pem file after registration, keep it in a safe place, this file is like a key for login, and you can not download it again if you lose it.

2. Under Network & Security --> Security Groups --> Inbound , remenber to open port 80 by adding a new rule. (Type: TCP, Port:80), cause my app use port 80 fot listening.

2. Both IP and DNS address will change after each restarts, so we should use elastic IP address. (TO DO)

3. Register RDS, put DB on RDS instead of server.(TO DO)

_<AWS>_

[back](./)
