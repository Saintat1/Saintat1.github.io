---
layout: default
---

## Server Configuration

### Ubuntu, make sure you have installed the following( Use sudo apt-get install openssh-server):



<p>openssh-server: SSH service</p>
<p>gunicorn: support gevent</p>
<p>Nginx: Web Server</p>
<p>python-gevent: 同步变异步协程</p>
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


```ruby
# Ruby code with syntax highlighting
GitHubPages::Dependencies.gems.each do |gem, version|
  s.add_dependency(gem, "= #{version}")
end
```

[back](./)
