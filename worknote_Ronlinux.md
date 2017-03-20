Run R script on Linux with cron tab
1. Install r on linux：

-add "deb http://stat.ethz.ch/CRAN/bin/linux/ubuntu trusty/" and "deb https://<my.favorite.ubuntu.mirror>/ trusty-backports main restricted universe" to /etc/apt/sources.list file

-$sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

-sudo apt-get update

-sudo apt-get install r-base

-sudo apt-get install r-base-dev


2. Use crontab to run scheduled task:

- Put your own r script under a folder, e.g. /ect/rcronjob/test.R
- Creat a test.sh file under the same file, with content,

```bash
#! /bin/bash
Rscript /etc/rcronjob/test.R
```

- Grand execution to .sh file by

```bash
sudo chmod +x test.sh
```

-Using crontab

```bash
sudo crontab -e
```

add

```bash
* * * * * /etc/rcronjob/test.sh
```
at the bottom of the file, and then save (Ctrl+X), and everything is done.



3. 命令格式： crontab [-u user] file crontab [-u user] [-e|-l|-r]

user: 用户
file: 文件名
-e: 编辑某个用户的crontab文件内容。
-l： 显示某个用户的文件内容
-r: 从/var/spool/cron目录中删除某个用户的crontab文件
-i: 再删除用户的crontab文件时给确认提示

<p>输入格式： 分 时 日 月 星期 命令</p>
<p>输入格式： * * * * * /etc/rcronjob/test.sh</p>