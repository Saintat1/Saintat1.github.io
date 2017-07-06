---
layout: post
title: Git rebase usage
date: 2017-07-06
tags: Git 
---
#### Git Rebase Usage

##### Merge

将master分支合并到feature分支最简单的方法是用

```git checkout feature```

```git merge master```

Or, ```git merge master feature```

如果master分支非常活跃，多少会污染分支历史， 所以作为替代选项， 我们可以使用***rebase***

##### Rebase

将feature分支并入master分支：

```git checkout feature```

```git rebase master```

如此会把整个feature分支移动到master之后，有效地把所有master分支上新的提交并入过来。但是，rebase为原分支上每一个提交创建一个新的提交，重写了项目历史。

![https://camo.githubusercontent.com/626197748d8d8493b194ce59874b71897c88c39f/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f30332e737667](https://camo.githubusercontent.com/626197748d8d8493b194ce59874b71897c88c39f/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f30332e737667)



最大的好处是会避免不必要的合并提交，更容易地查看项目历史

缺点：安全性和可跟踪性。rebase不会有合并提交中附带的信息，看不到feature分支中并入了上游的哪些更改。

##### 交互式Rebase

交互式rebase允许我们更改 并入新分支的提交， 提供了对分支上提交历史完整的控制。 一般用于将feature分支并入master分支之前，清理混乱的历史。

开始交互式rebase过程：

```git checkout feature```

``` git rebase -i master```

会打开一个文本编辑器，显示所有将被移动的提交：

```
pick 33d5b7a Message for commit #1
pick 9480b3d Message for commit #2
pick 5c67e61 Message for commit #3
```

定义了rebase被执行后分支回事什么样子，更改***pick*** 或是重新排序来改变分支的历史。比如， 第二个提交修复了第一个提交中的小问题，就可以用```fixup```命令将其合并为1个提交

```
pick 33d5b7a Message for commit #1
fixup 9480b3d Message for commit #2
pick 5c67e61 Message for commit #3
```

保存后关闭，git会按指令来执行rebase:

![](https://camo.githubusercontent.com/b685d6f2a7b4ecf6896fa2439e8da2fb958195fd/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f30342e737667)

好处就在于忽略了不重要的提交，让历史更加清晰易读。

##### Rebase黄金法则

***绝不要在公共的分支上使用它，比如把master分支rebase到你的feature分支***

![](https://camo.githubusercontent.com/b3d06635fdadff5863f94aa53b16bba69452f04f/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f30352e737667)

这时系统会认为你的master分支已经和别人的master分叉了， 所以再用```git rebase```之前, 确认只有自己在这个分支上工作。

##### 强制推送

如果想把rebase之后的master分支推送到远程仓库，会被系统组织，因为两个分支包含冲突， 但可以用--force标记来强行推送

```git push --force```

##### 工作流

##### 本地清理

![](https://camo.githubusercontent.com/890e91bbd54876ff01865403164de70fe47b555b/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f30372e737667)

```git
git checkout feature
git rebase -i HEAD~3
```

如果想用这个方法重写整个feature分支， ```git merge-base``` 可以给出feature分支开始分叉的基。 ``` git merge-base feature master```给出基提交的id, 将其传给```git rebase```

##### 将上游分支上的更改并入feature分支

![](https://camo.githubusercontent.com/6758dd2be664491c52dc4c246939f1ad5a14fba9/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f30382e737667)

![](https://camo.githubusercontent.com/c45e2609be5941aaedac397b08770be35d490db7/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f30392e737667)

##### 用Pull Request进行审查

1. 来自其他开发者的任何更改都应该用`git merge` 而不是`git rebase` 来并入


2. 在提交pull request前用交互式的rebase进行代码清理通常是一个好的做法。

##### 并入通过的功能分支

![](https://camo.githubusercontent.com/7a158568c55aa3b65bc58a648aabb17b36573eaa/68747470733a2f2f7777772e61746c61737369616e2e636f6d2f6769742f696d616765732f7475746f7269616c732f616476616e6365642f6d657267696e672d76732d7265626173696e672f31302e737667)

