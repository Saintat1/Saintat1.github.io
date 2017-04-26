---
layout: post
title: Web Scraping Dynamic Loaded Page
date: 2017-04-20
tags: R  
---
### Preface

Sometimes it's hard to do web scraping because: 1. You need to handle login page 2. You need to click on some button to get what you want. 3. The data in some table is dynamic loaded, you won't get it if you ignore it's JavaScript file. Finally I found a way using **phantomjs** + **javascript** + **rvest(R)** to solve this problem, it's super flexible and straight forward.

##### 1. Download and install phantomjs

PhantomJS is a headless WebKit, here we use it to open the dynamically loaded web page. You can download it from http://phantomjs.org/

##### 2. Configure the `scraper.js`

1. Use `document.getElementById("element").value="XXXX"` to fill a specific cell in a form.


2. Use `document.forms[0].submit();` to submit a form, use index to submit the specific form.

 	3. Use document.getElementsByName("Action")[1].click() to imitate a click action, useful when you want  	 to get content form a different tab, use index if there are multiple buttons under the same name.
 	4. You can adjust the waiting time between each section use `interval = setInterval(executeRequestsStepByStep,30000);` ,but make sure the website is fully loaded.

```javascript
var steps=[];
var testindex = 0;
var loadInProgress = false;//This is set to true when a page is still loading

/*********SETTINGS*********************/
var webPage = require('webpage');
var page = webPage.create();
page.settings.localToRemoteUrlAccessEnabled  = true;
/*********SETTINGS END*****************/

console.log('All settings loaded, start with execution');
page.onConsoleMessage = function(msg) {
    console.log(msg);
};
/**********DEFINE STEPS THAT FANTOM SHOULD DO***********************/
steps = [

	//Step 1 - Open home page
    function(){
        console.log('Step 1 - Open WSI home page');
        page.open("https://www.wsitrader.com/WeightedForecast/PowerGas/WSIWeightedDDForecast", function(status){
			
		});
    },
	//Step 2 - Populate and submit the login form
    function(){
        console.log('Step 2 -  submit the login form');
		page.evaluate(function(){
			document.getElementById("Account").value="XXXX";
            document.getElementById("Password").value="XXXX";
            document.getElementById('Profile').value="XXXX@XXXX.com";
            document.forms[0].submit();
		});
    },
   //Step 3 - Populate and submit the second login form
    function(){
        console.log('Step 3 -  submit the email form');
		page.evaluate(function(){
            document.getElementById('Profile').value="tbroersma@guzmanenergy.com";
            document.getElementsByName("Action")[1].click();
		});
    },
	//Step 4 - Save Web Page
    function(){
		console.log("Step 4 - Save Web Page");
         var fs = require('fs');
		 var result = page.content;
        fs.write('test.html',result,'w');
    },
];
/**********END STEPS THAT FANTOM SHOULD DO***********************/

//Execute steps one by one
interval = setInterval(executeRequestsStepByStep,30000);

function executeRequestsStepByStep(){
    if (loadInProgress == false && typeof steps[testindex] == "function") {
        //console.log("step " + (testindex + 1));
        steps[testindex]();
        testindex++;
    }
    if (typeof steps[testindex] != "function") {
        console.log("test complete!");
        phantom.exit();
    }
}

/**
 * These listeners are very important in order to phantom work properly. Using these listeners, we control loadInProgress marker which controls, weather a page is fully loaded.
 * Without this, we will get content of the page, even a page is not fully loaded.
 */
page.onLoadStarted = function() {
    loadInProgress = true;
    console.log('Loading started');
};
page.onLoadFinished = function() {
    loadInProgress = false;
    console.log('Loading finished');
};
page.onConsoleMessage = function(msg) {
    console.log(msg);
};
```

Save this file as scaper.js under your working directory in R.

And run `system("phantomjs scraper.js > result.html")` in R, the webpage will be saved as result.html under the same folder.