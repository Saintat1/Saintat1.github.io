---
layout: post
title: Slack API in R
date: 2017-04-10
tags: R  
---
### Preface
It is very convenient for me to use slack to supervise the status of running program, so I developed a simple slack-r api. Once some errors are catched, I'll get a slack message send by slack bot, it is good for debuging and problem solving. If you have any suggestions, please comment below.

[github page](https://github.com/Saintat1/R-SlackAPI)

Below is the code, before using, fill the below part with your own *webhook_url*:
```
incoming_webhook_url <- "https://hooks.slack.com/services/XXXXXX/XXXX/XXXXXXXX"
    messager.name <- "XXXXXX"
    upload.end.point <-  "https://slack.com/api/files.upload"
    upload.token <- "XXXX-XXXXXXXXXX-XXXXXX-XXXXXXX-XXXXXX"
    upload.channel = ""
```


```
    #' ############################################################################
    #' Slack API
    #' 
    #' @author: Weihan Li
    #' 
    #' @usage: slack.simple.message
    #'         slack.link.message
    #'         slack.detailed.message
    #' 
    #' 
    #' Simple Message: slack.simple.message(text,channel)
    #' @example  slack.simple.message("text","@colin")
    #'           slack.simple.message("text","#general")
    #' 
    #' Message with link: slack.link.message(urlText,url,text,target)
    #' @example  slack.link.message("text","www.google.com","@colin","www.google.com")
    #' 
    #' Detailed Message : slack.detailed.message(target,pretext,title,title.link,text,subtitle,
    #'                                        subcontent,imageurl,footer,footericon,color,author)
    #' @example 
    #' slack.detailed.message(target="@colin",pretext = "pretext is here",
    #'                        title = "title is here",title.link = "www.google.com",
    #'                        text = "text is here",
    #'                        subtitle = "subtitle is here"
    #'                        subcontent="subcontnet", author = "colin",
    #'                        imageurl = "https://platform.slack-edge.com/img/default_application_icon.png",
    #'                        )
    #' 
    #' Upload File: slack.upload(filename,title,comments,channels)
    #' @example slack.upload("C:\\Users\\xxx\\Desktop\\combine_1.PNG",
    #'                                 "title","comments","@colin")
    #' 
    #' 
    #' 
    #' Most argument are self explanatory
    #' @param: target which channel to post the message to (chr)
    #' @imageurl: put the url of a image here (chr)
    #' 
    #' ############################################################################
    suppressMessages({
      if (!require("gplots")) {
        install.packages("gplots", repos = "http://cran.us.r-project.org")
      }
      require("gplots")
      
      if (!require("rjson")) {
        install.packages("rjson", repos = "http://cran.us.r-project.org")
      }
      require("rjson")
      
      if (!require("httr")) {
        install.packages("httr", repos = "http://cran.us.r-project.org")
      }
      require("httr")
    })
    ###############################################################################
    # Token for GE slack
    ###############################################################################
    incoming_webhook_url <- "https://hooks.slack.com/services/XXXXXX/XXXX/XXXXXXXX"
    messager.name <- "XXXXXX"
    upload.end.point <-  "https://slack.com/api/files.upload"
    upload.token <- "XXXX-XXXXXXXXXX-XXXXXX-XXXXXXX-XXXXXX"
    upload.channel = ""
    ###############################################################################
    # Function Part
    ###############################################################################
    
    #--------------------------Simple-Message--------------------------------------
    slack.simple.message <- function(text,target){
      payload <- toJSON(list(text = text,
                             username = messager.name,
                             channel = target))
      post.request(payload)
    }
    #---------------------------Message-with-Link----------------------------------
    slack.link.message <- function(text,url,target,hrefText){
      text.temp <- paste0( text,": <" , url , "|" , hrefText , ">");
      payload <- toJSON(list(text = text.temp,
                             username = messager.name,
                             channel = target))
      post.request(payload)
    }
    #--------------------------------Detailed-Message------------------------------
    slack.detailed.message <- function(target,pretext,title,title.link,text,
                                       subtitle,subcontent,imageurl,footer,
                                       footericon,color,author){
      
      if(missing(target)){ stop("Pleas specify the channel!")}
      
      payload <- paste0('{"username" :',formatter(messager.name),
                        '"channel": ',formatter(target),
                        '"attachments":[{',
                        #'"fallback": ',pretext,
                        '"color": ', formatter(ifelse(missing(color),"#db5569",col2hex(color))),
                        ifelse(missing(pretext),'',paste0('"pretext":' ,formatter(pretext))),
                        ifelse(missing(author),'',paste0('"author_name":' ,formatter(author))),
                        #'"author_link":', "http://flickr.com/bobby/",
                        #'"author_icon":', "http://flickr.com/icons/bobby.jpg",
                        ifelse(missing(title),'',paste0('"title":' ,formatter(title))),
                        ifelse(missing(title.link),'',paste0('"title_link":' ,formatter(title.link))),
                        ifelse(missing(text),'',paste0('"text":' ,formatter(text))),
                        '"fields": [{',
                        ifelse(missing(subtitle),'',paste0('"title":' ,formatter(subtitle))),
                        ifelse(missing(subcontent),'',paste0('"value":' ,formatter(subcontent))),
                        '"short":', 'false',
                        '}],',
                        ifelse(missing(imageurl),'',paste0('"image_url":' ,formatter(imageurl))),
                        #'"thumb_url":', "http://example.com/path/to/thumb.png",
                        ifelse(missing(footer),'"footer":"GE Slack API",',paste0('"footer":' ,formatter(footer))),
                        ifelse(missing(footericon),'"footer_icon":"https://platform.slack-edge.com/img/default_application_icon.png",',paste0('"footer_icon":' ,formatter(footericon))),
                        '"ts":', as.numeric(Sys.time()),
                        '}]}')
      
      POST(url = incoming_webhook_url,body = payload,encode = "json",add_headers(`Content-Type` = "application/json"))
      return(invisible())
    }
    #----------------------Message-with-attached-file------------------------------
    slack.upload <- function(filename, title=basename(filename),
                             comments=basename(filename),
                             channels="", api_token="") {
      
      file.path <- path.expand(filename)
      
      if (file.exists(f_path)) {
        
        f_name <- basename(f_path)
        
        loc <- Sys.getlocale('LC_CTYPE')
        Sys.setlocale('LC_CTYPE','C')
        on.exit(Sys.setlocale("LC_CTYPE", loc))
        
        
        res <- POST(url = upload.end.point,
                          add_headers(`Content-Type` = "multipart/form-data"),
                          body = list( file = upload_file(file.path), filename = f_name,
                                     title = title, initial_comment = comments,
                                     token = api_token, channels = channels))
        
        return(invisible(res))
        
      } else {
        stop(sprintf("File [%s] not found", file.path), call.=FALSE)
      }
      
    }
    ###############################################################################
    # Basic Function Part
    ###############################################################################
    formatter <- function(string){
      if(missing(string) || string == "") {return("")}
      return(paste0("\"",string,"\"",","))
    }
    
    post.request <- function(payload){
      POST(url = incoming_webhook_url,body = payload,encode = "json")
      return(invisible())
    }
    
    
    
    

```