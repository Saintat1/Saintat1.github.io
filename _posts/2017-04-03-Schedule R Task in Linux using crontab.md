**Run R script on Linux with cron tab**
2. Install r on linux： 
 - add "deb http://stat.ethz.ch/CRAN/bin/linux/ubuntu trusty/" and "deb https://<my.favorite.ubuntu.mirror>/ trusty-backports main restricted universe" to /etc/apt/sources.list file
 - $sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
 - $sudo apt-get update
 - $sudo apt-get install r-base
 - $sudo apt-get install r-base-dev
3. Use crontab to run scheduled task:
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
 - at the bottom of the file, and then save (Ctrl+X), and everything is done.
4. format： "crontab [-u user] file crontab [-u user] [-e|-l|-r]"
 - user: 用户
 - file: 文件名 
 - -e: edit crontab task list
 - -l： show content
 - input format： min hour day month week commmand
 - 输入格式： * * * * * /etc/rcronjob/test.sh
 - Example: Rscript /etc/rcronjob/systime.R > /etc/rcronjob/outputFile.txt 2 > /etc/rcronjob/errorFile.txt
5. Edit crontab file:
 - use vi editor to add/delete cron job
 - Press `I` to enter insert mode
 - Use 'ESC' to quit edit mode, input `:` to enter commandline mode.
 - `q!` quit without saving
 - `wq` save and quit