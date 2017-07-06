---
layout: post
title: JavaScript Notes
date: 2017-02-06 
tags: JavaScript  
---
### JavaScript Notes

#### 浏览器

1. 浏览器对象

   **window**

   window对象充当全局作用域，并且表示浏览器窗口

   window.innerWidth: 浏览器窗口的内部宽度（净宽，除去菜单栏等）

   window.innerHeight: 浏览器窗口的内部高度

   outerWidth，outerHeight则显示整个宽高

   ​

   ​

   **navigator**

   表示浏览器的信息，常用属性：

   - navigator.appName：浏览器名称；
   - navigator.appVersion：浏览器版本；
   - navigator.language：浏览器设置的语言；
   - navigator.platform：操作系统类型；
   - navigator.userAgent：浏览器设定的`User-Agent`字符串。

   ​

   **screen**

   表示屏幕的信息

   - screen.width：屏幕宽度，以像素为单位；
   - screen.height：屏幕高度，以像素为单位；
   - screen.colorDepth：返回颜色位数，如8、16、24。

   ​**location**

   ​表示当前页面的URL信息：

```javascript
location.href//地址
location.protocol; // 'http'
location.host; // 'www.example.com'
location.port; // '8080'
location.pathname; // '/path/index.html'
location.search; // '?a=1&b=2'
location.hash; // 'TOP'
location.assign()//加载一个新页面
ocation.reload()//重新加载当前页面
```

​	**document**

​	表示当前页面，document对象是整个DOM的根节点，向下找元素时，可以用

​	```getElementById()```,```getElementsByTagName()```，```document.getElementsByClassName()```。结果有多个元素时可以用下标遍历。

​	

​	document.cookie

​	cookie是由服务器发送的key-value标示符，HTTP协议是无状态的，服务器就可以用COOKIE来区分是哪个用户发过来的请求。用户登录后，服务器发送一个cookie给浏览器，此后访问时会在请求头上附上该COOKIE，加以区别。这样，JS可以读取到用户的登录信息，类似于

```javascript
<html>
    <head>
        <script src="http://www.foo.com/jquery.js"></script>
    </head>
    ...
</html>
```

的引用是危险的。解决方法：服务器在设置Cookie时可以使用httpOnly。

​	**history**（不应该再使用）

​	history.back() 前进

​	history.forward() 后退

2. 操作DOM

   **选择：**

   ​```document.getElementById('test-table').getElementsByTagName('tr')```

   ​**更新：**

   ​第一种方法，修改```innerHTML```，HTML会被编码，如``` <span style="color:red">RED</span>```

   ​第二种方法，修改```innerText```, HTML不会被编码

   ​修改CSS: 

```javascript
var p = document.getElementById('p-id');
p.style.color = '#ff0000';
p.style.fontSize = '20px';
p.style.paddingTop = '2em';
```

 	**插入：**

​	第一种方法，```appendChild```,把一个子节点添加到父节点的最后一个子节点。如果插入的子节点已经存在于当前的文档树，这个节点会首先从原位置被删除，再插入到新的位置:

```javascript
<p id="js">JavaScript</p>
<div id="list">
    <p id="java">Java</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
</div>
```

```javascript
var 
	js = document.getElementById('js'),
    list = document.getElementById('list');
list.appendChild(js);
```

```javascript
<div id="list">
    <p id="java">Java</p>
    <p id="python">Python</p>
    <p id="scheme">Scheme</p>
    <p id="js">JavaScript</p>
</div>
```

​	如果要新创建一个节点再插入，

```javascript
var
    list = document.getElementById('list'),
    haskell = document.createElement('p');
haskell.id = 'haskell';
haskell.innerText = 'Haskell';
list.appendChild(haskell);
```

​	动态创建一个节点然后添加到DOM树中

```javascript
var d = document.createElement('style');
d.setAttribute('type', 'text/css');
d.innerHTML = 'p { color: red }';
document.getElementsByTagName('head')[0].appendChild(d);
```

​	**insertBefore**

​	用于把节点插入到指定的位置，用法```parentElement.insertBefore(newElement, referenceElement)```

​	**删除：**

​	调用父节点的`removeChild`删除子节点

```javascript
var self = document.getElementById('to-be-removed'); //要删除的节点
var parent = self.parentElement;//要删除节点的父节点
var removed = parent.removeChild(self);//删除该节点
removed === self; // true  删除的节点储存在removed中，和self一致
```



3. 操作表单
   - 文本框，```<input type="text">```用于输入文本
   - 口令框，```<input type="password">```用于输入口令
   - 单选框，```<input type="radio">```用于选择一项
   - 复选框，```<input type="checkbox">```用于选择多项
   - 下拉框，```<select>```用于选择一项
   - 隐藏文本，对应的```<input type="hidden">```,用户不可见，但表单提交时会把隐藏文本发送到服务器

   ​**获取值**

   ​```input.value```,可以用于大部分情况。但对于复选框，需要用```checked```判断

   ​**设置值**

   ​```mon.checked = true``` 

   ​```input.value = 'test@example.com'```

   ​**HTML5控件**

```javascript
<input type="date" value="2015-07-01"> //日期选择器，value为默认时间
<input type="datetime-local" value="2015-07-01T02:03:04">
<input type="color" value="#ff0000"> //颜色选择器
```

​	**提交表单**

​	方法一，点击按钮时提交表单

```javascript
<!-- HTML -->
<form id="test-form">
    <input type="text" name="test">
    <button type="button" onclick="doSubmitForm()">Submit</button>
</form>

<script>
function doSubmitForm() {
    var form = document.getElementById('test-form');
    // 可以在此修改form的input...
    // 提交form:
    form.submit();
}
</script>
```

​	但是浏览器默认的是点击```<button type="submit">```,或用户在最后一个输入框按回车键是提交表单。

​	方法二，响应```form```本身的```onsubmit```事件，在提交form时做修改

```javascript
<!-- HTML -->
<form id="test-form" onsubmit="return checkForm()">
    <input type="text" name="test">
    <button type="submit">Submit</button>
</form>

<script>
function checkForm() {
    var form = document.getElementById('test-form');
    // 可以在此修改form的input...
    // 继续下一步:
    return true;//true 告诉浏览器继续提交；如果是flase，浏览器不会继续提交form,通常对应用户输入有误
}
</script>
```

​	**在检查和修改`<input>`时，要充分利用`<input type="hidden">`来传递数据**

​	一般情况：

```javascript
<!-- HTML -->
<form id="login-form" method="post" onsubmit="return checkForm()">
    <input type="text" id="username" name="username">
    <input type="password" id="password" name="password">
    <button type="submit">Submit</button>
</form>

<script>
function checkForm() {
    var pwd = document.getElementById('password');
    // 把用户输入的明文变为MD5:
    pwd.value = toMD5(pwd.value);  //但是口令框会突然变成32个*
    // 继续下一步:
    return true;
}
</script>
```

​	改进：用```<input type="hidden">```

```javascript
<!-- HTML -->
<form id="login-form" method="post" onsubmit="return checkForm()">
    <input type="text" id="username" name="username">
    <input type="password" id="input-password">   //注意， 没有name属性的数据不会被提交！！！！
    <input type="hidden" id="md5-password" name="password">
    <button type="submit">Submit</button>
</form>

<script>
function checkForm() {
    var input_pwd = document.getElementById('input-password');
    var md5_pwd = document.getElementById('md5-password');
    // 把用户输入的明文变为MD5:
    md5_pwd.value = toMD5(input_pwd.value);
    // 继续下一步:
    return true;
}
</script>
```

4. 操作文件

上传文件的控件```<input type="file">```

JS可以在提交表单是对文件扩展名做检查

```javascript
var f = document.getElementById('test-file-upload');
var filename = f.value; // 文件全路径
if (!filename || !(filename.endsWith('.jpg') || filename.endsWith('.png') || filename.endsWith('.gif'))) {
    alert('Can only upload image file.');
    return false;
}
```

HTML5的File API提供了```File```和```FileReader```两个主要对象，可以获得文件信息并读取文件

```javascript
var
    fileInput = document.getElementById('test-image-file'),
    info = document.getElementById('test-file-info'),
    preview = document.getElementById('test-image-preview');
// 监听change事件:
fileInput.addEventListener('change', function () {
    // 清除背景图片:
    preview.style.backgroundImage = '';
    // 检查文件是否选择:
    if (!fileInput.value) {
        info.innerHTML = '没有选择文件';
        return;
    }
    // 获取File引用:
    var file = fileInput.files[0];
    // 获取File信息:
    info.innerHTML = '文件: ' + file.name + '<br>' +
                     '大小: ' + file.size + '<br>' +
                     '修改: ' + file.lastModifiedDate;
    if (file.type !== 'image/jpeg' && file.type !== 'image/png' && file.type !== 'image/gif') {
        alert('不是有效的图片文件!');
        return;
    }
    // 读取文件:
    var reader = new FileReader();
    reader.onload = function(e) {
        var
            data = e.target.result; // 'data:image/jpeg;base64,/9j/4AAQSk...(base64编码)...'            
        preview.style.backgroundImage = 'url(' + data + ')';
    };
    // 以DataURL的形式读取文件:
    reader.readAsDataURL(file);
});
```

5. AJAX

6. jQuery

   jQuery把所有函数封装在`jQuery`变量内，该变量的别名是`$`

   **选择器**

   ​	按id: ```var div = $('#abc')```; 结果不会返回```undefined```或者```null```, 如果是空会返回```[]```

   ​	按tag: ```var ps = $('p')```;

   ​	按class:``` var a = ('.red');``` 同时包含多个节点: ```var a = ('.red.green');```

