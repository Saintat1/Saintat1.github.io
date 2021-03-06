---
layout: post
title: Run R Script on Linux with Crontab
date: 2017-04-03 
tags: R  
---
### Preface
Recently the in-house server in our company crashed several times because of the heavy duty, so we finally decide to move important cronjobs to AWS. Running java on linux is easy, but for R it's a little different.

### Run R script on Linux with cron tab
1. Install r on linux： 
 - add `deb http://stat.ethz.ch/CRAN/bin/linux/ubuntu trusty/` and `deb https://<my.favorite.ubuntu.mirror>/ trusty-backports main restricted universe` to /etc/apt/sources.list file
 - `$sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9`
 - `$sudo apt-get update`
 - `$sudo apt-get install r-base`
 - `$sudo apt-get install r-base-dev`
2. Use crontab to run scheduled task:
 - Put your own r script under a folder, e.g. /ect/rcronjob/test.R
 - Creat a test.sh file under the same file, with content,
 ```bash
 #! /bin/bash
 Rscript /etc/rcronjob/test.R
 ```
 - Grand execution to .sh file by
 ```bash
 sudo chmod +x  ERCOT_Balday_matching.sh
 ```
 - Using crontab
 ```bash
 sudo crontab -e
 ```
 - add "* * * * * /etc/rcronjob/test.sh"
3. format： "crontab [-u user] file crontab [-u user] [-e|-l|-r]"
 - -e: edit crontab task list
 - -l： show content
 - input format： min hour day month week commmand
 - example： * * * * * /etc/rcronjob/test.sh
 - Example: Rscript /etc/rcronjob/systime.R > /etc/rcronjob/outputFile.txt 2 > /etc/rcronjob/errorFile.txt
4. Edit crontab file:
 - use vi editor to add/delete cron job
 - Press `I` to enter insert mode
 - Use 'ESC' to quit edit mode, input `:` to enter commandline mode.
 - `q!` quit without saving
 - `wq` save and quit