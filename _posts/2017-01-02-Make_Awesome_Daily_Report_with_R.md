---
layout: post
title: Awesome Daily Report with R
date: 2017-01-02 
tags: R
---
### Preface
Recently, my company need a daily report to show the position we keep and the margin call we need to prepare, so our manage team can use the money more efficient. We used to do it in java, but the old java-version daily report is not straight forward engough and hard to amend, so I find a way to implement it R, and the result is amazing!

### Configuration
In this task, I used below softwares and packages:
>* R
	- Rmarkdown: the key to make beautiful report
	- Webshot: Currently, all email sending packages(mailR,sendmailR,etc) in R do not support sending html file with .css , which means we will lose all our fancy visual effects. Here Webshot in R is a good solution, it can take a snapshot of out latex or html file so all the fancy features will be kept
	- mailR: email sending tool in R
	- slackr:  (optional, if you are using slack) Send slack message with R
>* Task Schduler in Windows (If you are not familiar with it, try Rstudio, Rstudio now have in house Addins to add cronjob)